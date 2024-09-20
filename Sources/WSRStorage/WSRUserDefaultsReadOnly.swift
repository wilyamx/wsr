//
//  WSRUserDefaultsReadOnly.swift
//  WSR
//
//  Created by William S. Rena on 9/17/24.
//

import Foundation

@propertyWrapper
public struct WSRUserDefaultsReadOnly<Value: WSRConstantConvertible> {
    private var value: Value
    private var key: String
    
    private let container: UserDefaults = UserDefaults.standard

    public var wrappedValue: Value {
        if let object = container.object(forKey: key),
           let value = Value(storeValue: object) {
            return value
        }
        return value
    }

    public init(_ key: String, wrappedValue: Value) {
        self.key = key
        self.value = wrappedValue
        
        container.set(wrappedValue, forKey: key)
    }
}
