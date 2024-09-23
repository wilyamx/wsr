//
//  File.swift
//  
//
//  Created by William S. Rena on 9/23/24.
//

import WSRCommon

public protocol WSRViewStateProtocol {
    var viewState: WSRViewState { get set }
    var showErrorAlert: Bool { get set }
    //
    var loadingMessage: String { get set }
    var errorMessage: String { get set }
    var errorAlertType: WSRErrorAlertType { get set }
}

public protocol WSRPersitableProtocol {
    func persist() async
}

public protocol WSRMockableProtocol {
    var mockData: Bool { get set }
}
