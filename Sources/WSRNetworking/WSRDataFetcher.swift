//
//  WSRDataFetcher.swift
//  WSR
//
//  Created by William S. Rena on 9/23/24.
//

import SwiftUI
import WSRCommon

open class WSRDataFetcher: ObservableObject,
                      WSRViewStateProtocol,
                      WSRPersitableProtocol,
                      WSRMockableProtocol {
    
    // MARK: - View State Protocol
    
    @Published public var viewState: WSRViewState = .empty
    @Published public var showErrorAlert: Bool = false
    
    public var loadingMessage: String = ""
    public var errorMessage: String = ""
    public var errorAlertType: WSRErrorAlertType = .none
    
    // MARK: - Mockable Protocol
    
    public var mockData: Bool = false
    
    // MARK: - API Service Protocol
    
    public var service: WSRApiServiceProtocol
    
    public init(service: WSRApiServiceProtocol = WSRApiService()) {
        self.service = service
    }
    
    // MARK: - WSRPersitable Protocol
    
    open func persist() async {
        fatalError("Override this method and define your own implementation.")
    }
}

// MARK: - WSRViewState Protocol

public extension WSRDataFetcher {
    func requestStarted(message: String? = nil) {
        DispatchQueue.main.async {
            self.errorMessage = ""
            self.viewState = .loading
            
            if let message = message {
                self.loadingMessage = message
            }
        }
    }
    
    func requestFailed(reason: String, errorAlertType: WSRErrorAlertType = .none) {
        DispatchQueue.main.async {
            self.errorMessage = reason
            self.viewState = .error
            
            self.errorAlertType = errorAlertType
            if errorAlertType != .none {
                self.showErrorAlert = true
            }
        }
    }
    
    func requestSuccess() {
        DispatchQueue.main.async {
            self.errorMessage = ""
            self.viewState = .populated
            self.showErrorAlert = false
        }
    }
    
    func resetErrorStatuses() {
        viewState = .empty
        showErrorAlert = false
        
        loadingMessage = ""
        errorMessage = ""
        errorAlertType = .none
    }
}
