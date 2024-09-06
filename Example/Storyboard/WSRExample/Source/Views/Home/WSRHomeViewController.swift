//
//  WSRHomeViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/5/24.
//

import UIKit
import WSRComponents
import SuperEasyLayout

class WSREHomeViewController: WSREViewController {
    
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
                componentsButton,
                networkingButton
            ])
        ])
    }
    
    override func setupConstraints() {
        verticalStackView.left == view.left + 20
        verticalStackView.right == view.right - 20
        verticalStackView.centerY == view.centerY
        
        componentsButton.height == 44
        networkingButton.height == 44
    }
    
    override func setupActions() {
        componentsButton.tapHandlerAsync = { [weak self] _ in
            self?.coordinator?.showcaseComponents()
        }
        networkingButton.tapHandlerAsync = { [weak self] _ in
            self?.coordinator?.showcaseNetworking()
        }
    }
}
