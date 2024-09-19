//
//  UppercaseProperty.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import SwiftUI
import Combine
import WSRStorage

@propertyWrapper
struct UppercaseProperty: DynamicProperty {
    @State private var value: String
    private let publisher: CurrentValueSubject<String?, Never>
    
    var wrappedValue: String {
        get { value }
        nonmutating set {
            value = newValue.uppercased()
            publisher.send(newValue)
        }
    }
    
//    var projectedValue: Binding<String> {
//        Binding(
//            get: { wrappedValue },
//            set: { wrappedValue = $0 }
//        )
//    }
    
    var projectedValue: WSRProjectedValue<String> {
        WSRProjectedValue(
            binding: Binding(
                get: { wrappedValue },
                set: { wrappedValue = $0 ?? "" }
            ),
            publisher: publisher)
    }
    
    init(wrappedValue: String) {
        _value = State(wrappedValue: wrappedValue.uppercased())
        publisher = CurrentValueSubject(wrappedValue.uppercased())
    }
}
