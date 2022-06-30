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
        
    }
    
    
}
