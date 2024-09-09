//
//  WSREComponentsViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/6/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents
import WSRUtils
import SuperEasyLayout

class WSREComponentsViewController: WSREViewController {
    weak var coordinator: WSREComponentsCoordinator?
    
    let viewModel = WSREComponentsViewModel()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    private lazy var createChatRoomButton: WSRButton = {
        let view = WSRButton()
        view.text = "CREATE CHAT ROOM"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var chatRoomListButton: WSRButton = {
        let view = WSRButton()
        view.text = "CHAT ROOM LIST"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var activeButton: WSRButton = {
        let view = WSRButton()
        view.text = "ACTIVE"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var inactiveButton: WSRButton = {
        let view = WSRButton()
        view.text = "INACTIVE"
        view.colorStyle = .inactive
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var disabledButton: WSRButton = {
        let view = WSRButton()
        view.text = "DISABLED"
        view.colorStyle = .inactive
        view.isEnabled = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wsrLogger.info(message: "Coordinator: \(coordinator)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        title = "WSR Components"
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addSubviews([
            verticalStackView.addArrangedSubviews([
                createChatRoomButton,
                chatRoomListButton,
                activeButton,
                inactiveButton,
                disabledButton
            ])
        ])
    }
    
    override func setupConstraints() {
        verticalStackView.left == view.left + 20
        verticalStackView.right == view.right - 20
        verticalStackView.centerY == view.centerY
        
        createChatRoomButton.height == 44
        chatRoomListButton.height == 44
        activeButton.height == 44
        inactiveButton.height == 44
        disabledButton.height == 44
    }
    
    override func setupActions() {
        createChatRoomButton.tapHandlerAsync = { [weak self] _ in
            self?.coordinator?.showCreateChatRoom()
        }
        chatRoomListButton.tapHandlerAsync = { [weak self] _ in
            self?.coordinator?.showChatRoomList()
        }
        activeButton.tapHandlerAsync = { _ in
            wsrLogger.info(message: "activeButton.tapHandlerAsync")
        }
        inactiveButton.tapHandlerAsync = { _ in
            wsrLogger.info(message: "inactiveButton.tapHandlerAsync")
        }
        disabledButton.tapHandlerAsync = { _ in
            wsrLogger.info(message: "disabledButton.tapHandlerAsync")
        }
    }
    
}
