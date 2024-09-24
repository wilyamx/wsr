//
//  WSRENetworkingViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/6/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents_UIKit
import WSRCommon
import SuperEasyLayout

class WSRENetworkingViewController: WSREViewController {

    weak var coordinator: WSREHomeCoordinator?
    
    let viewModel = WSRENetworkingViewModel()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    private lazy var requestButton: WSRButton = {
        let view = WSRButton()
        view.text = "REQUEST"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wsrLogger.info(message: "Coordinator: \(coordinator)")
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        title = "WSR Networking"
        wsr_NavigationBarDefaultStyle()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addSubviews([
            verticalStackView.addArrangedSubviews([
                requestButton
            ])
        ])
    }
    
    override func setupConstraints() {
        verticalStackView.left == view.left + 20
        verticalStackView.right == view.right - 20
        verticalStackView.centerY == view.centerY
        
        requestButton.height == 44
    }
    
    override func setupActions() {
        requestButton.tapHandlerAsync = { _ in
            wsrLogger.info(message: "requestButton.tapHandlerAsync")
        }
    }
}
