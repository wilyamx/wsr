//
//  WSRUserDefaultsReadAndWrite.swift
//  WSR
//
//  Created by William S. Rena on 9/17/24.
//

import Foundation
import WSRCommon

@propertyWrapper
public struct WSRUserDefaults_UIKit<Value: WSRConstantConvertible> {
    private let key: String
    private let defaultValue: Value
    private let notificationName: Notification.Name

    private let container: UserDefaults = UserDefaults.standard

    public var projectedValue: WSRObservable<Value> {
        WSRObservable(notificationName: notificationName, default: defaultValue)
    }

    public var wrappedValue: Value {
        get {
            WSRCommonConstants.appInfoQueue.sync(flags: .barrier) {
                if let object = UserDefaults.standard.object(forKey: key),
                   let value = Value(storeValue: object) {
                    return value
                }
                return defaultValue
            }
        }
        set {
            WSRCommonConstants.appInfoQueue.sync(flags: .barrier) {
                let _ = container.object(forKey: key)
                if let userDefaultValue = newValue.storeValue {
                    container.set(userDefaultValue, forKey: key)
                } else {
                    container.removeObject(forKey: key)
                }
                container.synchronize()
            }
        }
    }

    public init(_ key: String, default: Value) {
        self.key = key
        defaultValue = `default`
        notificationName = Notification.Name("com.wsr.notificationForAppInfo.\(key)")
    }
}
