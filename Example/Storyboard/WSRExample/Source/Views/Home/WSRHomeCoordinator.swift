//
//  WSRHomeCoordinator.swift
//  WSRExample
//
//  Created by William S. Rena on 9/5/24.
//

import UIKit
import wsr

class WSREHomeCoordinator: WSRCoordinatorProtocol {
    var childCoordinators = [WSRCoordinatorProtocol]()
    var navigationController: UINavigationController?

    var window: UIWindow?

    init(window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        let viewController = WSREHomeViewController()
        viewController.coordinator = self

        navigationController?.pushViewController(viewController, animated: false)

        guard let navigationController = navigationController
        else {
            window?.rootViewController = viewController
            return
        }

        viewController.wsr_NavigationBarDefaultStyle(backgroundColor: UIColor.accent, tintColor: .white)
        window?.rootViewController = navigationController
    }
    
    func showcaseComponents() {
        let viewController = WSREComponentsViewController()
        viewController.coordinator = self

        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showcaseNetworking() {
        let viewController = WSRENetworkingViewController()
        viewController.coordinator = self

        navigationController?.pushViewController(viewController, animated: true)
    }
}
