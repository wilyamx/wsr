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
    
    // MARK: - Navigation
    
    public func wsrNavigationBarDefaultStyle(backgroundColor: UIColor = .black, tintColor: UIColor = .white) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = backgroundColor
            appearance.shadowColor = .clear

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance

            let titleAttribute = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            appearance.titleTextAttributes = titleAttribute
        } else {
            let navigationBar = navigationController?.navigationBar
            navigationBar?.standardAppearance.backgroundColor = backgroundColor
            navigationBar?.standardAppearance.shadowColor = .clear
        }
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.backButtonTitle = ""
    }
}
