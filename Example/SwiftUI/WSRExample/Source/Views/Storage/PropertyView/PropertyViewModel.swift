//
//  PropertyViewModel.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import Foundation
import WSRUtils

final class PropertyViewModel: ObservableObject {
    @Published var count: Int = 0
    @Published var shout: String = "quiet"
    
    @UppercaseProperty var message: String = "INITIAL MESSAGE"
}
