//
//  WSREComponentsCoordinator.swift
//  WSRExample
//
//  Created by William S. Rena on 9/6/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents

class WSREComponentsCoordinator: WSRCoordinatorProtocol {
    var childCoordinators = [WSRCoordinatorProtocol]()
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {

    }
    
    func showCreateChatRoom() {
        let viewController = WSRECreateChatRoomViewController()
        //viewController.coordinator = self

        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showChatRoomList() {
        let viewController = WSREChatRoomListViewController()
        //viewController.coordinator = self

        navigationController?.pushViewController(viewController, animated: true)
    }
}
