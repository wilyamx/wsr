//
//  WSREnvironment.swift
//  WSR
//
//  Created by William S. Rena on 9/23/24.
//

import Foundation

public struct WSREnvironment {
    public enum WSRKeys {
        static let baseURL = "BASE_URL"
    }
    
    // Get the BASE_URL
    public static let baseURL: String = {
        return "https://api.thecatapi.com"
        
        guard let baseURLProperty = Bundle.main.object(forInfoDictionaryKey: WSRKeys.baseURL) as? String else {
            fatalError("BASE_URL not found")
        }
        return baseURLProperty
    }()
    
    public static let catBaseURL: String = "https://api.thecatapi.com"
    public static let gitHubBaseURL: String = "https://api.github.com"
}
