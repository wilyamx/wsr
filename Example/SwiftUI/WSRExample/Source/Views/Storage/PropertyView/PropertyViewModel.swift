//
//  PropertyViewModel.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import Foundation
import WSRCommon
import Combine

final class PropertyViewModel: ObservableObject {
    @Published var count: Int = 0
    @Published var shout: String = "quiet"
    
    @UppercaseProperty var message: String = "INITIAL MESSAGE" {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { child in
            if var observedProperty = child.value as? PublishedWrapper {
                wsrLogger.info(message: "\(observedProperty)")
                observedProperty.objectWillChange = self.objectWillChange
            }
        }
    }
}
