//
//  WSRConstantKeychainType.swift
//  WSR
//
//  Created by William S. Rena on 9/20/24.
//

import Foundation

// MARK: - Protocols

public protocol WSRConstantKeychainType: WSRConstantConvertible {
    static var type: String { get }
}

// MARK: - Extensions

extension Optional: WSRConstantKeychainType where Wrapped: WSRConstantKeychainType {
    public static var type: String { Wrapped.type }
}

extension String: WSRConstantKeychainType {
    public init?(storeValue: Any) {
        guard let value = storeValue as? String else { return nil }
        self = value
    }

    public var storeValue: Any? { self }
    public static var type: String { "string" }
    public static var defaultValue: Any? { "" }
}
