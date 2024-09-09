//
//  WSREChatRoomListViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/9/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents

class WSREChatRoomListViewController: WSREViewController {

    let viewModel = WSREChatRoomListViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Setups
    
    override func setupNavigation() {
        title = "Chat Room List"
    }

    override func setupLayout() {
        super.setupLayout()
    }
    
    override func setupConstraints() {
        
    }
    
    override func setupActions() {
        
    }
    
    override func setupBindings() {
        
    }
}
