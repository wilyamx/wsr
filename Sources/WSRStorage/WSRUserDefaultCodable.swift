//
//  WSRUserDefaultCodable.swift
//  WSR
//
//  Created by William S. Rena on 9/17/24.
//

import Foundation
import SwiftUI
import Combine

@propertyWrapper
public struct WSRUserDefaultCodable<T: Codable>: DynamicProperty {
    // SwiftUI
    @State private var value: T?
    // Combine
    private let publisher: CurrentValueSubject<T?, Never>
    
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
        nonmutating set {
            if let newValue = newValue {
                let data = try! JSONEncoder().encode(newValue)
                container.set(data, forKey: key)
                value = data as? T
            }
            else {
                container.set(newValue, forKey: key)
                value = newValue
            }
        }
    }
    
    public var projectecValue: WSRProjectedValue<T> {
        WSRProjectedValue(
            binding: Binding(
                get: { wrappedValue },
                set: { wrappedValue = $0 }
            ),
            publisher: publisher
        )
    }
    
    public init(_ key: String) {
        self.key = key
        
        _value = State(wrappedValue: nil)
        publisher = CurrentValueSubject(nil)
    }
}
