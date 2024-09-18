//
//  WSREUserModel.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import Foundation

struct WSREUserModel: Codable {
    let name: String
    let age: Int
    
    var description: String {
        return "\(name) at \(age)"
    }
}
