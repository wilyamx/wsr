//
//  WSRECreateChatRoomViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/6/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRUtils

class WSRECreateChatRoomViewController: WSREViewController {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        title = "Create Chat Room"
        wsr_NavigationBarDefaultStyle()
    }
}
