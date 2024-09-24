//
//  FileManagerProperty.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import WSRStorage
import WSRCommon

extension FileManager {
    static func documentsPath(key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}

@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    @State private var title: String
    let key: String
    
    var wrappedValue: String {
        get { title }
        nonmutating set { save(newValue: newValue) }
    }
    
    var projectedValue: Binding<String> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
        })
    }
    
    init(wrappedValue: String, _ key: String) {
        self.key = key
        
        do {
            title = try String(contentsOf: FileManager.documentsPath(key: key), encoding: .utf8)
            print("SUCCESS READ")
        } catch {
            title = wrappedValue
            print("ERROR READ: \(error)")
        }
    }
    
    func save(newValue: String) {
        do {
            // When atomically is set to true, it means that the data will be written to a temporary file first.
            // When atomically is set to false, the data is written directly to the specified file path.
            try newValue.write(to: FileManager.documentsPath(key: key), atomically: false, encoding: .utf8)
            title = newValue
//            print(NSHomeDirectory())
            print("SUCCESS SAVED")
        } catch {
            print("EEROR SAVING: \(error)")
        }
    }
}
