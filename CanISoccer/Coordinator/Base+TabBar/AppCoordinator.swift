//
//  AppCoordinator.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    var delegate: CoordinatorFinishDelegate?
    
    var presenter: SoccerNavigationViewController
    
    var childCoordinators: [Coordinator]
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.presenter = SoccerNavigationViewController()
        self.childCoordinators = []
    }

    func start() {
        window.rootViewController = presenter
        let coordinator = MainTabBarCoordinator(presenter: presenter)
        coordinator.start()
        window.makeKeyAndVisible()
    }
}
