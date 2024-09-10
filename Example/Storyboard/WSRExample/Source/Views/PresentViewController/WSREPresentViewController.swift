//
//  WSREPresentViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/10/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRUtils

class WSREPresentViewController: WSREViewController {
    
    private var navigationBar: WSRENavigationBar? {
        navigationController?.navigationBar as? WSRENavigationBar
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        navigationBar?.title = "Present View Controller"
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        let randomInt = Int.random(in: 0..<2)
        if randomInt == 0 {
            navigationBar?.showProfileButtons = true
        }
        else if randomInt == 1 {
            navigationBar?.showDismissButtonOnly = true
        }
    }
    
    override func setupActions() {
        navigationBar?.profileTapHandlerAsync = { _ in
            wsrLogger.info(message: "navigationBar?.profileTapHandlerAsync")
        }
        
        navigationBar?.closeTapHandlerAsync = { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
}
