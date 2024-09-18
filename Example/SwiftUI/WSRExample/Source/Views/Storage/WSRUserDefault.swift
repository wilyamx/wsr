//
//  WSRUserDefaultCodable2.swift
//  WSRExample
//
//  Created by William S. Rena on 9/17/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import SwiftUI
import Combine
import WSRUtils

@propertyWrapper
public struct WSRUserDefault<T>: DynamicProperty {
    // SwiftUI (Tested)
    @State private var value: T?
    // Combine
    private let publisher: CurrentValueSubject<T?, Never>
    
    private let key: String
    private let defaultValue: T
    private let container: UserDefaults = UserDefaults.standard

    public var wrappedValue: T {
        get {
            guard let object = container.object(forKey: key) as? T
            else { return defaultValue }
            
            return object
        }
        set {
            container.set(newValue, forKey: key)
            
            value = newValue
            publisher.send(newValue)
        }
    }
    
//    public var projectedValue: Binding<T> {
//        Binding(
//            get: { wrappedValue },
//            set: { wrappedValue = $0 }
//        )
//    }
    
    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        
        guard let object = container.object(forKey: key) as? T
        else {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            
            wsrLogger.info(message: "No data!")
            return
        }
        
        _value = State(wrappedValue: object)
        publisher = CurrentValueSubject(object)
        
        wsrLogger.error(message: "Initialized! \(object)")
    }
}
