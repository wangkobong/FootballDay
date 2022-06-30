//
//  MainTabBarViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    enum TabBarItem: CaseIterable {
        case home, searchGround, favorite, schedule
        
        var image: UIImage? {
            switch self {
            case .home: return UIImage(named: "location.fill")
            case .searchGround: return UIImage(named: "magnifyingglass")
            case .favorite: return UIImage(named: "star.fill")
            case .schedule: return UIImage(named: "calendar.badge.plus")
            }
        }
        
        var selectedImage: UIImage? {
            switch self {
            case .home: return UIImage(named: "location.fill")
            case .searchGround: return UIImage(named: "magnifyingglass")
            case .favorite: return UIImage(named: "star.fill")
            case .schedule: return UIImage(named: "calendar.badge.plus")
            }
        }
        
        func coordinator(presenter: SoccerNavigationViewController) -> Coordinator {
            switch self {
            case .home: return HomeCoordinator(presenter: presenter)
            case .searchGround: return SearchGroundCoordinator(presenter: presenter)
            case .favorite: return FavoriteCoordinator(presenter: presenter)
            case .schedule: return ScheduleCoordinator(presenter: presenter)
            }
        }
    }
    
    // MARK: - PROPERTIES
}
