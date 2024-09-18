//
//  FileManagerCodableProperty.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import SwiftUI
import Combine
import WSRStorage
import WSRUtils

@propertyWrapper
struct FileManagerCodableProperty<T: Codable>: DynamicProperty {
    
    @State private var value: T?
    
    let key: String
    
    var wrappedValue: T? {
        get { value }
        nonmutating set { save(newValue: newValue) }
    }
    
    var projectedValue: Binding<T?> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    init(_ key: String) {
        self.key = key
        
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            
            _value = State(wrappedValue: object)
            wsrLogger.info(message: "SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            wsrLogger.info(message: "ERROR READ: \(error)")
        }
    }
    
    func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentsPath(key: key))
            
            value = newValue
            wsrLogger.info(message: "SUCCESS SAVED")
        } catch {
            wsrLogger.info(message: "ERROR SAVING: \(error)")
        }
    }
}
