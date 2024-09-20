//
//  WSRStorageConstants.swift
//  WSR
//
//  Created by William S. Rena on 9/20/24.
//

import Foundation
import KeychainAccess

final public class WSRStorageConstants {
    public static var wsr_keychainServiceIdentifier: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? "com.wsr.Keychain"
    }
    
    public static var wsr_keychain: Keychain = .init(service: wsr_keychainServiceIdentifier)
        .synchronizable(false)
        .accessibility(.afterFirstUnlockThisDeviceOnly)
}
