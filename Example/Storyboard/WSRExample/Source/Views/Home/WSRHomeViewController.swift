//
//  WSRHomeViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/5/24.
//

import UIKit
import SuperEasyLayout
import WSRComponents_UIKit
import WSRUtils

class WSREHomeViewController: WSREViewController {
    
    weak var coordinator: WSREHomeCoordinator?
    
    let viewModel = WSREHomeViewModel()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    private lazy var componentsButton: WSRButton = {
        let view = WSRButton()
        view.text = "COMPONENTS"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var storageButton: WSRButton = {
        let view = WSRButton()
        view.text = "STORAGES"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var networkingButton: WSRButton = {
        let view = WSRButton()
        view.text = "NETWORKING"
        view.colorStyle = .inactive
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
        title = "WSR Swift Packager"
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addSubviews([
            verticalStackView.addArrangedSubviews([
                componentsButton,
                storageButton,
                networkingButton
            ])
        ])
    }
    
    override func setupConstraints() {
        verticalStackView.left == view.left + 20
        verticalStackView.right == view.right - 20
        verticalStackView.centerY == view.centerY
        
        componentsButton.height == 44
        storageButton.height == 44
        networkingButton.height == 44
    }
    
    override func setupActions() {
        componentsButton.tapHandlerAsync = { [weak self] _ in
            self?.coordinator?.showcaseComponents()
        }
        storageButton.tapHandlerAsync = { [weak self] _ in
            self?.coordinator?.showcaseStorage()
        }
        networkingButton.tapHandlerAsync = { [weak self] _ in
            self?.coordinator?.showcaseNetworking()
        }
    }
}
