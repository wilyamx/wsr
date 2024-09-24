//
//  WSREPresentViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/10/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRCommon
import WSRComponents_UIKit
import SuperEasyLayout

class WSREPresentViewController: WSREViewController {
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    private lazy var alertButton: WSRButton = {
        let view = WSRButton()
        view.text = "ALERT"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var activityButton: WSRButton = {
        let view = WSRButton()
        view.text = "ACTIVITY INDICATOR"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    private var navigationBar: WSRENavigationBar? {
        navigationController?.navigationBar as? WSRENavigationBar
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        navigationBar?.title = "Present View Controller"
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addSubviews([
            verticalStackView.addArrangedSubviews([
                alertButton,
                activityButton,
            ])
        ])
        
        let randomInt = Int.random(in: 0..<2)
        if randomInt == 0 {
            navigationBar?.showProfileButtons = true
        }
        else if randomInt == 1 {
            navigationBar?.showDismissButtonOnly = true
        }
    }
    
    override func setupConstraints() {
        verticalStackView.left == view.left + 20
        verticalStackView.right == view.right - 20
        verticalStackView.centerY == view.centerY
        
        alertButton.height == 44
        activityButton.height == 44
    }
    
    override func setupActions() {
        navigationBar?.profileTapHandlerAsync = { _ in
            wsrLogger.info(message: "navigationBar?.profileTapHandlerAsync")
        }
        navigationBar?.closeTapHandlerAsync = { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        alertButton.tapHandlerAsync = { [weak self] _ in
            guard let self else { return }
            
            let isDelete = await showChatRoomDeleteAlert(in: self, chatName: "Lorem Ipsum")
            let password = await showChatRoomPasswordAlert(in: self, chatName: "Lorem Ipsum")
            debugPrint("Alert selection: isDelete? \(isDelete), password? \(password ?? "??")")
        }
        
        activityButton.tapHandlerAsync = { _ in
            await WSREIndicatorController.shared.show(message: "Fetching")
            await Task.sleep(seconds: 3.0)
            await WSREIndicatorController.shared.dismiss(message: "Fetching Done", type: .check(3))
        }
    }
    
    // MARK: - Alert
    
    @MainActor
    @discardableResult
    private func showChatRoomDeleteAlert(in viewController: UIViewController, chatName: String) async -> Bool {
        return await WSRAsyncAlertController<Bool>(
            message: "Are you sure you want to delete the chat room \(chatName) and all it's messages?",
            title: "Delete confirmation"
        )
        .addButton(title: "Yes, I want to delete this chat room", style: .destructive, returnValue: true)
        .addButton(title: "Cancel", returnValue: false)
        .tintColor(color: UIColor.accent)
        .register(in: viewController)
    }
    
    @MainActor
    @discardableResult
    private func showChatRoomPasswordAlert(in viewController: UIViewController, chatName: String) async -> String? {
        return await AsyncInputAlertController<String>(
            title: "\(chatName) requires a password",
            message: "Please enter the password."
        )
        .addButton(title: "Ok")
        .tintColor(color: UIColor.accent)
        .register(in: viewController)
    }
}
