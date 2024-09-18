//
//  WSRUserDefaultCodable_UIKit.swift
//  WSR
//
//  Created by William S. Rena on 9/17/24.
//

import Foundation
import UIKit

//@propertyWrapper
//public struct WSRUserDefaultCodable_UIKit<T: WSRConstantConvertible> {
//    private let key: String
//    private var defaultValue: T? = nil
//
//    private let notificationName: Notification.Name
//    private let container: UserDefaults = UserDefaults.standard
//
//    public var wrappedValue: T {
//        get {
//            if let data = container.object(forKey: key) as? Data,
//               let object = try? JSONDecoder().decode(T.self, from: data) {
//                return object
//            }
//            else { return defaultValue}
//        }
//        nonmutating set {
//            if let newValue = newValue {
//                let data = try! JSONEncoder().encode(newValue)
//                container.set(data, forKey: key)
//            }
//            else {
//                container.set(newValue, forKey: key)
//            }
//        }
//    }
//    
//    var projectedValue: WSRObservable<T> {
//        WSRObservable(notificationName: notificationName, default: defaultValue)
//    }
//    
//    public init(_ key: String) {
//        self.key = key
//        notificationName = Notification.Name("WSRUserDefaultCodable_UIKit.\(key)")
//    }
//}
