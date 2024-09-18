//
//  UppercaseProperty.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import SwiftUI

@propertyWrapper
struct UppercaseProperty: DynamicProperty {
    @State private var title: String
    
    var wrappedValue: String {
        get { title }
        nonmutating set { title = newValue.uppercased() }
    }
    
    var projectedValue: Binding<String> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    init(wrappedValue: String) {
        title = wrappedValue.uppercased()
    }
}
