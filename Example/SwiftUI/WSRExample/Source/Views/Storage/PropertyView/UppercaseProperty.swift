//
//  UppercaseProperty.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import SwiftUI
import Combine
import WSRStorage
import WSRCommon

protocol PublishedWrapper: DynamicProperty {
    var objectWillChange: ObservableObjectPublisher? { get set }
}

@propertyWrapper
struct UppercaseProperty: PublishedWrapper {
    var objectWillChange: ObservableObjectPublisher?
    
    @State private var value: String
    private let publisher: CurrentValueSubject<String?, Never>
    
    var wrappedValue: String {
        get { value }
        nonmutating set {
            value = newValue.uppercased()
            publisher.send(newValue.uppercased())
            
            objectWillChange?.send()
            wsrLogger.info(message: "Set wrappedValue: \(newValue.uppercased())")
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
