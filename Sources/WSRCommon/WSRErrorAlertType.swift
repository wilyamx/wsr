//
//  WSRErrorAlertType.swift
//  WSR
//
//  Created by William S. Rena on 9/23/24.
//

import Foundation

public enum WSRErrorAlertType: Equatable {
    case somethingWentWrong
    case connectionTimedOut
    case noInternetConnection
    case badRequest
    case domain
    case none
    case custom(String)
    
    public func getIconSystemName() -> String {
        switch self {
        case .somethingWentWrong,
                .badRequest,
                .connectionTimedOut,
                .domain:
            return "exclamationmark"
        case .noInternetConnection: return "wifi.slash"
        case .none: return "checkmark"
        case .custom(_): return "person.fill.questionmark"
        }
    }
    
    public func getTitle() -> String {
        switch self {
        case .somethingWentWrong: return "Something Went Wrong"
        case .badRequest: return "Bad Request"
        case .connectionTimedOut: return "Connection Timed Out"
        case .noInternetConnection: return "No Internet Connection"
        case .domain: return "Domain Connection"
        case .none: return "Works well"
        case .custom(_): return "Custom Error"
        }
    }
    
    func getMessage() -> String {
        switch self {
        case .somethingWentWrong: return "Sorry, an error occured while trying to sign in.\nPlease try again later."
        case .connectionTimedOut: return "Sorry, connection timeout.\nPlease try again later."
        case .noInternetConnection: return "Please try again when your connection is available."
            
        case .badRequest: return "Sorry, bad request."
        case .domain: return "Could not connect to the server."
        case .none: return "Work as expected."
        case .custom(let message): return message
        }
    }
    
    public func getActionButtonText() -> String {
        switch self {
        case .somethingWentWrong,
                .badRequest,
                .connectionTimedOut,
                .noInternetConnection,
                .domain,
                .none,
                .custom(_):
            return "Got it"
        }
    }
}
