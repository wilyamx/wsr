//
//  WSRPropertyWrappers.swift
//  WSR
//
//  Created by William Rena on 7/27/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import Foundation

public protocol WSRConstantConvertible {
    init?(storeValue: Any)
    var storeValue: Any? { get }
}

public protocol WSRConstantKeychainType: WSRConstantConvertible {
    static var type: String { get }
}

extension Optional: WSRConstantConvertible where Wrapped: WSRConstantConvertible {
    public init?(storeValue: Any) {
        guard let value = Wrapped(storeValue: storeValue) else { return nil }
        self = .some(value)
    }

    public var storeValue: Any? {
        switch self {
        case .some(let value): value.storeValue
        case .none: nil
        }
    }

    public static var defaultValue: Any? { nil }
}

extension Optional: WSRConstantKeychainType where Wrapped: WSRConstantKeychainType {
    public static var type: String { Wrapped.type }
}

extension Int: WSRConstantConvertible {
    public init?(storeValue: Any) {
        guard let value = storeValue as? Int else { return nil }
        self = value
    }

    public var storeValue: Any? { self }
    public static var defaultValue: Any? { 0 }
}

extension Bool: WSRConstantConvertible {
    public init?(storeValue: Any) {
        guard let value = storeValue as? Bool else { return nil }
        self = value
    }

    public var storeValue: Any? { self }
    public static var defaultValue: Any? { false }
}

extension String: WSRConstantKeychainType {
    public init?(storeValue: Any) {
        guard let value = storeValue as? String else { return nil }
        self = value
    }

    public var storeValue: Any? { self }
    public static var type: String { "string" }
    public static var defaultValue: Any? { "" }
}

extension Date: WSRConstantConvertible {
    public init?(storeValue: Any) {
        guard let value = storeValue as? Date else { return nil }
        self = value
    }

    public var storeValue: Any? { self }
    public static var type: String { "date" }
    public static var defaultValue: Any? { Date() }
}

@propertyWrapper
public struct WSRUserDefaultsReadOnly<Value: WSRConstantConvertible> {
    private var key: String
    private var defaultValue: Value
    
    private let container: UserDefaults = UserDefaults.standard

    public var wrappedValue: Value {
        if let object = container.object(forKey: key),
           let value = Value(storeValue: object) {
            return value
        }
        return defaultValue
    }

    public init(_ key: String, default: Value) {
        self.key = key
        defaultValue = `default`
    }
}

@propertyWrapper
public struct WSRUserDefaultsReadAndWrite<Value: WSRConstantConvertible> {
    private let key: String
    private let defaultValue: Value

    private let container: UserDefaults = UserDefaults.standard
    private var appInfoQueue = DispatchQueue(label: "WSRAppInfoQueue", qos: .userInteractive)

    //        var projectedValue: Observable<Value> {
    //            Observable(notificationName: notificationName, default: defaultValue)
    //        }

    public var wrappedValue: Value {
        get {
            appInfoQueue.sync(flags: .barrier) {
                if let object = UserDefaults.standard.object(forKey: key),
                   let value = Value(storeValue: object) {
                    return value
                }
                return defaultValue
            }
        }
        set {
            appInfoQueue.sync(flags: .barrier) {
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
    }
}

@propertyWrapper
public struct WSRUserDefaultCodable<T: Codable> {
    private let key: String
    private var defaultValue: T? = nil

    private let container: UserDefaults = UserDefaults.standard

    public var wrappedValue: T? {
        get {
            if let data = container.object(forKey: key) as? Data,
               let object = try? JSONDecoder().decode(T.self, from: data) {
                return object
            }
            else { return defaultValue}
        }
        set {
            if let newValue = newValue {
                let data = try! JSONEncoder().encode(newValue)
                container.set(data, forKey: key)
            }
            else {
                container.set(newValue, forKey: key)
            }
        }
    }
    
    public init(_ key: String, default: T) {
        self.key = key
        defaultValue = `default`
    }
}

public class WSRUserDefaults: NSObject {
    @WSRUserDefaultsReadAndWrite("key", default: false) var hasSound: Bool
}
