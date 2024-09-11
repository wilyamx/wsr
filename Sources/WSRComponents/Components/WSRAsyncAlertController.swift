//
//  WSRAsyncAlertController.swift
//  WSR
//
//  Created by William Rena on 7/28/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import UIKit

public class WSRAsyncAlertController<T> {
    private let alertController: UIAlertController
    private var continuation: CheckedContinuation<T, Never>?

    private let title: String?
    private let message: String?

    public init(message: String? = nil, title: String? = nil,
         name: String? = nil, preferredStyle: UIAlertController.Style = .alert) {
        self.title = title
        self.message = message
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        self.alertController.view.tintColor = UIColor.getPackageColor(named: "wsr_accent")
    }

    @discardableResult
    public func addButton(
        title: String, style: UIAlertAction.Style = .default, isPreferred: Bool = false,
        isCancel: Bool = false, returnValue: T
    ) -> Self {
        let newAlertAction = UIAlertAction(title: title, style: style) { [weak self] action in
            guard let continuation = self?.continuation else { fatalError("You must use registerAsync.") }
            continuation.resume(returning: returnValue)
        }
        alertController.addAction(newAlertAction)
        if isPreferred { alertController.preferredAction = newAlertAction }
        return self
    }

    @discardableResult
    public func register(in parentViewController: UIViewController) async -> T {
        await withCheckedContinuation { continuation in
            self.continuation = continuation
            DispatchQueue.main.async {
                parentViewController.present(self.alertController, animated: true)
            }
        }
    }
}

public class AsyncInputAlertController<T> {
    private let alertController: UIAlertController
    private var continuation: CheckedContinuation<String?, Never>?

    private let title: String?
    private let message: String?

    public init(title: String? = nil, message: String? = nil,
         name: String? = nil, preferredStyle: UIAlertController.Style = .alert
    ) {
        self.title = title
        self.message = message

        self.alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        self.alertController.addTextField { textField in
            textField.text = name
        }
        self.alertController.view.tintColor = UIColor.getPackageColor(named: "wsr_accent")
    }

    @discardableResult
    public func addButton(
        title: String, style: UIAlertAction.Style = .default, isPreferred: Bool = false,
        isCancel: Bool = false
    ) -> Self {
        let newAlertAction = UIAlertAction(title: title, style: style) { [weak self] action in
            guard let continuation = self?.continuation else { fatalError("You must use registerAsync.") }
            guard let alertController = self?.alertController else { return }

            let inputText = alertController.textFields!.first?.text
            continuation.resume(returning: inputText)
        }
        alertController.addAction(newAlertAction)
        if isPreferred { alertController.preferredAction = newAlertAction }
        return self
    }

    @discardableResult
    public func register(in parentViewController: UIViewController) async -> String? {
        await withCheckedContinuation { continuation in
            self.continuation = continuation
            DispatchQueue.main.async {
                parentViewController.present(self.alertController, animated: true)
            }
        }
    }
}
