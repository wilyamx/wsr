//
//  WSRFileLoaderError.swift
//  WSR
//
//  Created by William Rena on 5/11/23.
//

import UIKit

public enum WSRFileLoaderError: Error, LocalizedError, WSRActionableError {
    typealias CustomErrorActionType = ActionType

    case fileNotFound(String)
    case fileCannotLoad(Error)
    case parsing(Error)

    public var title: String? {
        switch self {
        case .fileNotFound: "File not found!"
        case .fileCannotLoad: "File cannot be load!"
        case .parsing: "Parsing error!"
        }
    }

    public var errorDescription: String? {
        switch self {
        case .fileNotFound(let filePath): "Invalid file path: \(filePath)"
        case .fileCannotLoad: "File is corrupted!"
        case .parsing(let error): "Parsing error! Please check the file source."
        }
    }

    public enum ActionType: WSRErrorActionType {
        case ok

        public var title: String {
            switch self {
            case .ok: "Ok"
            }
        }

        public var isPreferred: Bool {
            switch self {
            default: false
            }
        }

        public var isCancel: Bool {
            switch self {
            default: false
            }
        }
    }

    public var alertActions: [ActionType] {
        [.ok]
    }
}
