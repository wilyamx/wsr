//
//  WSRPropertyWrappers.swift
//  WSR
//
//  Created by William Rena on 7/27/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import Foundation

// MARK: - Protocols

public protocol WSRConstantConvertible {
    init?(storeValue: Any)
    var storeValue: Any? { get }
}

public protocol WSRConstantKeychainType: WSRConstantConvertible {
    static var type: String { get }
}

// MARK: - Extensions

extension Optional: WSRConstantConvertible where Wrapped: WSRConstantConvertible {
    public init?(storeValue: Any) {
        guard let value = Wrapped(storeValue: storeValue) else { return nil }
        self = .some(value)
    }

    public var storeValue: Any? {
        switch self {
        case .some(let value): value.storeValue
        case .none: nil
        }
    }

    public static var defaultValue: Any? { nil }
}

extension Optional: WSRConstantKeychainType where Wrapped: WSRConstantKeychainType {
    public static var type: String { Wrapped.type }
}

extension Int: WSRConstantConvertible {
    public init?(storeValue: Any) {
        guard let value = storeValue as? Int else { return nil }
        self = value
    }

    public var storeValue: Any? { self }
    public static var defaultValue: Any? { 0 }
}

extension Bool: WSRConstantConvertible {
    public init?(storeValue: Any) {
        guard let value = storeValue as? Bool else { return nil }
        self = value
    }

    public var storeValue: Any? { self }
    public static var defaultValue: Any? { false }
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

extension Date: WSRConstantConvertible {
    public init?(storeValue: Any) {
        guard let value = storeValue as? Date else { return nil }
        self = value
    }

    public var storeValue: Any? { self }
    public static var type: String { "date" }
    public static var defaultValue: Any? { Date() }
}
