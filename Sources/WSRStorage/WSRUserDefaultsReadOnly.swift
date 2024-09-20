//
//  WSRUserDefaultsReadOnly.swift
//  WSR
//
//  Created by William S. Rena on 9/17/24.
//

import Foundation

@propertyWrapper
public struct WSRUserDefaultsReadOnly<Value: WSRConstantConvertible> {
    private var defaultValue: Value
    private var key: String
    
    private let container: UserDefaults = UserDefaults.standard

    public var wrappedValue: Value {
        if let object = container.object(forKey: key),
           let value = Value(storeValue: object) {
            return value
        }
        return defaultValue
    }

    public init(_ key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
