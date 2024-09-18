//
//  PropertyViewModel.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import Foundation
import WSRUtils

final class PropertyViewModel: ObservableObject {
    @UppercaseProperty var message: String = "INITIAL MESSAGE" {
        willSet {
            wsrLogger.info(message: "willSet: \(message)")
            objectWillChange.send()
        }
    }
}
