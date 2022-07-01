//
//  MainTabBarCoordinator.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit

class MainTabBarCoordinator: NSObject, Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var delegate: CoordinatorFinishDelegate?
    
    var presenter: SoccerNavigationViewController
    
    var childCoordinators: [Coordinator]
    
    init(presenter: SoccerNavigationViewController) {
        self.presenter = presenter
        self.presenter.navigationBar.isHidden = true
        self.childCoordinators = []
    }
    
    func start() {
        let mainTabBarVC = MainTabBarViewController()
        mainTabBarVC.coordinatorFinishDelegate = self
        mainTabBarVC.tabBarItems.forEach { tabBarItem in
            let coordinator = tabBarItem.coordinator(presenter: presenter)
            coordinator.delegate = self
            childCoordinators.append(coordinator)
        }
    
        presenter.viewControllers = [mainTabBarVC]
    }
        
}
