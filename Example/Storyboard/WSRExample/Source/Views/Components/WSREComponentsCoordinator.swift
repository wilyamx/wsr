//
//  WSREComponentsCoordinator.swift
//  WSRExample
//
//  Created by William S. Rena on 9/6/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents_UIKit

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
    
    func showPresentViewController(on parentViewController: UIViewController) {
        let viewController = WSREPresentViewController()
        //viewController.coordinator = self

        let navigationController = UINavigationController(navigationBarClass: WSRENavigationBar.self,
                                                          toolbarClass: nil)
        navigationController.modalPresentationStyle = .overFullScreen
        //navigationController.transitioningDelegate = viewController.fadeInAnimator
        navigationController.viewControllers = [viewController]

        parentViewController.present(navigationController, animated: true)
    }
}
