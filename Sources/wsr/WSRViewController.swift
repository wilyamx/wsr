//
//  WSRViewController.swift
//  WSR
//
//
//  Created by William S. Rena on 9/5/24.
//

import UIKit

open class WSRViewController: UIViewController {
    
    // MARK: - View Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupLayout()
        setupConstraints()
        setupBindings()
        setupActions()
    }
    
    // MARK: - Setups

    open func setupNavigation() {}
    open func setupLayout() {}
    open func setupConstraints() {}
    open func setupBindings() {}
    open func setupActions() {}
}
