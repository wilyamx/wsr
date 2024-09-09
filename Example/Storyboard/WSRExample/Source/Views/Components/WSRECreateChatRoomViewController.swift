//
//  WSRECreateChatRoomViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/6/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import Foundation
import WSRComponents
import SuperEasyLayout

class WSRECreateChatRoomViewController: WSREViewController {
    private lazy var blurredBgView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.effect = UIBlurEffect(style: .regular)
        return view
    }()
    
    private lazy var containerView: WSRView = {
        let view = WSRView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.alignment = .leading
        return view
    }()
    
    private lazy var titleTextLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .wsr_title
        //view.textColor = .textColor(.title)
        view.lineBreakMode = .byCharWrapping
        view.text = "New Chat Room"
        return view
    }()

    private lazy var roomTextLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = .wsr_body
        //view.textColor = .textColor(.title)
        view.lineBreakMode = .byCharWrapping
        view.text = "Room Name"
        return view
    }()

    private lazy var roomTextField: WSRTextField = {
        let view = WSRTextField()
        view.borderStyle = .roundedRect
        return view
    }()

    private lazy var passwordTextLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = .wsr_body
        //view.textColor = .textColor(.title)
        view.lineBreakMode = .byCharWrapping
        view.text = "Password (optional)"
        return view
    }()

    private lazy var passwordTextField: WSRTextField = {
        let view = WSRTextField()
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        return view
    }()

    private lazy var createButton: WSRButton = {
        let view = WSRButton()
        view.text = "CREATE"
        view.colorStyle = .active
        view.isEnabled = false
        view.layer.cornerRadius = 8
        return view
    }()

    private lazy var cancelButton: WSRButton = {
        let view = WSRButton()
        view.text = "CANCEL"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        title = "Create Chat Room"
        wsr_NavigationBarDefaultStyle()
    }
    
    override func setupLayout() {
        view.backgroundColor = .clear
        
        addSubviews([
            blurredBgView,
            containerView.addSubviews([
                verticalStackView.addArrangedSubviews([
                    titleTextLabel,
                    roomTextLabel,
                    roomTextField,
                    passwordTextLabel,
                    passwordTextField,
                    createButton,
                    cancelButton
                ])
            ])
        ])
        
        verticalStackView.setCustomSpacing(20, after: titleTextLabel)
        verticalStackView.setCustomSpacing(15, after: roomTextField)
        verticalStackView.setCustomSpacing(20, after: passwordTextField)
        verticalStackView.setCustomSpacing(10, after: createButton)
    }
    
    override func setupConstraints() {
        blurredBgView.setLayoutEqualTo(view)
        
        containerView.width == UIScreen.main.bounds.width - 40
        containerView.centerX == view.centerX
        containerView.centerY == view.centerY
        
        verticalStackView.left == containerView.left + 20
        verticalStackView.right == containerView.right - 20
        verticalStackView.top == containerView.top + 20
        verticalStackView.bottom == containerView.bottom - 20
        
        titleTextLabel.left == verticalStackView.left
        titleTextLabel.right == verticalStackView.right

        roomTextField.left == verticalStackView.left
        roomTextField.right == verticalStackView.right
        roomTextField.height == 44

        passwordTextField.left == verticalStackView.left
        passwordTextField.right == verticalStackView.right
        passwordTextField.height == 44

        createButton.left == verticalStackView.left
        createButton.right == verticalStackView.right
        createButton.height == 44

        cancelButton.left == verticalStackView.left
        cancelButton.right == verticalStackView.right
        cancelButton.height == 44
    }
}
