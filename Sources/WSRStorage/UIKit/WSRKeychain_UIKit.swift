//
//  WSRKeychain_UIKit.swift
//  WSR
//
//  Created by William S. Rena on 9/20/24.
//

import Foundation
import WSRCommon

@propertyWrapper
struct WSRKeychain_UIKit<Value: WSRConstantKeychainType> {
    private let key: String
    private let defaultValue: Value
    private let notificationName: Notification.Name

    var projectedValue: WSRObservable<Value> {
        WSRObservable(notificationName: notificationName, default: defaultValue)
    }

    var wrappedValue: Value {
        get {
            WSRCommonConstants.appInfoQueue.sync(flags: .barrier) {
                switch Value.type {
                case "data":
                    if let object = WSRStorageConstants.wsr_keychain[data: key],
                       let value = Value(storeValue: object) {
                        return value
                    }
                case "string":
                    if let object = WSRStorageConstants.wsr_keychain[string: key],
                       let value = Value(storeValue: object) {
                        return value
                    }
                case "date":
                    if let object = WSRStorageConstants.wsr_keychain[string: key],
                       let date = Date(iso8601: object),
                       let value = Value(storeValue: date) {
                        return value
                    }
                case "int":
                    if let object = WSRStorageConstants.wsr_keychain[string: key],
                       let intValue = Int(safe: object),
                       let value = Value(storeValue: intValue) {
                        return value
                    }
                default:
                    return defaultValue
                }
                return defaultValue
            }
        }
        set {
            WSRCommonConstants.appInfoQueue.sync(flags: .barrier) {
                if let value = newValue.storeValue {
                    switch Value.type {
                    case "data":
                        WSRStorageConstants.wsr_keychain[data: key] = value as? Data
                    case "string":
                        WSRStorageConstants.wsr_keychain[string: key] = value as? String
                    case "date":
                        WSRStorageConstants.wsr_keychain[string: key] = (value as? Date)?.toIso8601
                    case "int":
                        let storeValue: String? = if let intValue = value as? Int { String(intValue) } else { nil }
                        WSRStorageConstants.wsr_keychain[string: key] = storeValue
                    default:
                        fatalError("You must set type.")
                    }
                } else {
                    try? WSRStorageConstants.wsr_keychain.remove(key)
                }
                let notification = Notification(name: notificationName,
                                                object: newValue)
                DispatchQueue.main.async {
                    NotificationQueue.default.enqueue(notification, postingStyle: .asap)
                }
            }
        }
    }

    init(_ key: String, default: Value) {
        self.key = key
        defaultValue = `default`
        notificationName = Notification.Name("notificationForAppInfo.\(key)")
    }
}
