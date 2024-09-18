//
//  FileManagerCodableStreamableProperty.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI
import Combine
import WSRStorage
import WSRUtils

enum FileManagerKeys: String {
    case userProfile
}

struct FileManagerKeypath<T:Codable> {
    let key: String
    let type: T.Type
}

struct FileManagerValues {
    static let shared = FileManagerValues()
    private init() {}
    
    let userProfile = FileManagerKeypath(key: "user_profile", type: WSREUserModel.self)
}

@propertyWrapper
struct FileManagerCodableStreamableProperty<T: Codable>: DynamicProperty {
    // SwiftUI
    @State private var value: T?
    // Combine
    private let publisher: CurrentValueSubject<T?, Never>
    
    let key: String
    
    var wrappedValue: T? {
        get { value }
        nonmutating set { save(newValue: newValue) }
    }
    
    var projectedValue: WSRProjectedValue<T> {
        WSRProjectedValue(
            binding: Binding(
                get: { wrappedValue },
                set: { wrappedValue = $0 }
            ),
            publisher: publisher
        )
    }
    
    init(_ key: String) {
        self.key = key
        
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            
            wsrLogger.info(message: "SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            
            wsrLogger.error(message: "ERROR READ: \(error)")
        }
    }
    
    init(_ key: KeyPath<FileManagerValues, FileManagerKeypath<T>>) {
        let keypath = FileManagerValues.shared[keyPath: key]
        
        let key = keypath.key
        self.key = key
        
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            
            wsrLogger.info(message: "SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            
            wsrLogger.error(message: "ERROR READ: \(error)")
        }
    }
    
    private func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentsPath(key: key))
            
            value = newValue
            publisher.send(newValue)
            
            wsrLogger.info(message: "SUCCESS SAVED")
        } catch {
            wsrLogger.error(message: "ERROR SAVING: \(error)")
        }
    }
}
