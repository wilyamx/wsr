//
//  WSRUserDefaultCodable.swift
//
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI
import Combine
import WSRUtils

@propertyWrapper
public struct WSRUserDefaultCodable<T: Codable>: DynamicProperty {
    // SwiftUI (Tested)
    @State private var value: T?
    // Combine
    private let publisher: CurrentValueSubject<T?, Never>

    private let key: String

    private let container: UserDefaults = UserDefaults.standard

    public var wrappedValue: T? {
        get { value }
        nonmutating set {
            do {
                let data = try JSONEncoder().encode(newValue)
                container.set(data, forKey: key)

                value = newValue
                publisher.send(newValue)

                if let value = value {
                    wsrLogger.info(message: "Saved New Value: \(value)")
                }
            } catch {
                wsrLogger.error(message: "Encoding error!")
            }
        }
    }

    public var projectedValue: Binding<T?> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    public init(_ key: String) {
        self.key = key

        guard let data = UserDefaults.standard.object(forKey: key) as? Data
        else {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)

            wsrLogger.info(message: "No data!")
            return
        }

        do {
            let object = try JSONDecoder().decode(T.self, from: data)

            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)

            wsrLogger.error(message: "Initialized!")

        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)

            wsrLogger.error(message: "Decoding Error!")
        }
    }
}
