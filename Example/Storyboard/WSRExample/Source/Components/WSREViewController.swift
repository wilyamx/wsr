//
//  WSREViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/6/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents

class WSREViewController: WSRViewController {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        wsr_NavigationBarDefaultStyle(backgroundColor: UIColor.accent, tintColor: .white)
    }
    
    // MARK: - Setups
    
    override func setupLayout() {
        view.backgroundColor = UIColor.getPackageColor(named: "wsr_mainBackground")
    }
}
