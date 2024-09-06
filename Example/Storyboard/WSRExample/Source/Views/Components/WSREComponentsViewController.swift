//
//  WSREComponentsViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/6/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import wsr
import SuperEasyLayout

class WSREComponentsViewController: WSREViewController {

    let viewModel = WSREComponentsViewModel()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
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
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        title = "WSR Swift Packager"
        wsr_NavigationBarDefaultStyle()
    }
    
    override func setupLayout() {
        view.backgroundColor = .white
        
        addSubviews([
            verticalStackView.addArrangedSubviews([
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
        
        activeButton.height == 44
        inactiveButton.height == 44
        disabledButton.height == 44
    }
    
    override func setupActions() {
        activeButton.tapHandlerAsync = { _ in
            wsrLogger.info(message: "1111")
        }
        inactiveButton.tapHandlerAsync = { _ in
            wsrLogger.info(message: "2222")
        }
        disabledButton.tapHandlerAsync = { _ in
            wsrLogger.info(message: "3333")
        }
    }
    
}
