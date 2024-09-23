//
//  WSRApiError.swift
//  WSR
//
//  Created by William S. Rena on 9/23/24.
//

import Foundation

public enum WSRApiError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case badRequest
    case url(URLError?)
    case parsing(DecodingError?)
    case serverError
    case unknown
    
    public var localizedDescription: String {
        // user feedback
        switch self {
        case .badURL, .parsing, .serverError, .unknown:
            return "Sorry, something went wrong."
        case .badRequest:
            return "Sorry, client error!"
        case .badResponse(_):
            return "Sorry, the connection to our server failed."
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong."
        }
    }
    
    public var description: String {
        //info for debugging
        switch self {
        case .serverError, .unknown: return "Unknown Error"
        case .badURL: return "Invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "URL Session Error"
        case .parsing(let error):
            return "Parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "Bad response with status code \(statusCode)"
        case .badRequest:
            return "Client error"
        }
    }
}
