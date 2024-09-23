//
//  WSRApiServiceProtocol.swift
//  WSR
//
//  Created by William S. Rena on 9/23/24.
//

import Foundation

public protocol WSRApiServiceProtocol {

    static func getURLSessionConfiguration() -> URLSessionConfiguration
    
    // MARK: - Restful methods
    
    func get<T: Decodable>(
        _ type: T.Type,
        path: String,
        queryItems: [URLQueryItem]?) async throws -> T
    
    func post(path: String, bodyParam: String)
    func put(path: String, bodyParam: String)
    func delete(path: String, bodyParam: String)
}
