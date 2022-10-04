////
////  MainTabBarViewController.swift
////  CanISoccer
////
////  Created by sungyeon kim on 2022/06/30.
////
//
//import UIKit
//
//class MainTabBarViewController: UITabBarController {
//    
//    enum TabBarItem: CaseIterable {
//        case home, searchGround, favorite, schedule
//        
//        var title: String? {
//            switch self {
//            case .home: return "날씨"
//            case .searchGround: return "구장검색"
//            case .favorite: return "즐겨찾기"
//            case .schedule: return "일정"
//            }
//        }
//        
//        var image: UIImage? {
//            switch self {
//            case .home: return UIImage(systemName: "location.fill")
//            case .searchGround: return UIImage(systemName: "magnifyingglass")
//            case .favorite: return UIImage(systemName: "star.fill")
//            case .schedule: return UIImage(systemName: "calendar.badge.plus")
//            }
//        }
//        
//        var selectedImage: UIImage? {
//            switch self {
//            case .home: return UIImage(systemName: "location.fill")
//            case .searchGround: return UIImage(systemName: "magnifyingglass")
//            case .favorite: return UIImage(systemName: "star.fill")
//            case .schedule: return UIImage(systemName: "calendar.badge.plus")
//            }
//        }
//        
//        func coordinator(presenter: SoccerNavigationViewController) -> Coordinator {
//            switch self {
//            case .home: return HomeCoordinator(presenter: presenter)
//            case .searchGround: return SearchGroundCoordinator(presenter: presenter)
//            case .favorite: return FavoriteCoordinator(presenter: presenter)
//            case .schedule: return ScheduleCoordinator(presenter: presenter)
//            }
//        }
//    }
//    
//    //MARK: - Properties
//    
//    var coordinator: HomeCoordinator?
//    
//    var tabBarItems: [TabBarItem] = TabBarItem.allCases
//    
//    var coordinatorFinishDelegate: CoordinatorFinishDelegate?
//    
//    //MARK: - Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViewControllers()
//        configureUI()
//        delegate = self
//    }
//    
//    deinit {
//        coordinatorFinishDelegate?.coordinatorDidFinish()
//    }
//    
//    //MARK: - Configures
//    
//    private func configureUI() {
//        tabBar.backgroundColor = .white
//        tabBar.isTranslucent = false
//    }
//    
//    //MARK: - Helpers
//    
//    private func setupViewControllers() {
//        let controllers = tabBarItems.map { generateTabBarController(item: $0) }
//        setViewControllers(controllers, animated: true)
//    }
//    
//    private func generateTabBarController(item: TabBarItem) -> SoccerNavigationViewController {
//        let navigationController = SoccerNavigationViewController()
//        let tabItem = UITabBarItem(title: item.title,
//                                   image: item.image,
//                                   selectedImage: item.selectedImage)
//        
////        tabItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
//        navigationController.tabBarItem = tabItem
//        let coordinator = item.coordinator(presenter: navigationController)
//        coordinator.start()
//        return navigationController
//    }
//
//}
//
//extension MainTabBarViewController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let tabBarIndex = tabBarController.selectedIndex
//        if tabBarIndex == 0 && tabBarController.selectedViewController == viewController {
//            let navVC = viewController as? SoccerNavigationViewController
//            let homeVC = navVC?.viewControllers[0] as? MainViewController
//
//        }
//        
//        if tabBarIndex == 1 && tabBarController.selectedViewController == viewController {
//            let navVC = viewController as? SoccerNavigationViewController
//            let searchGroundVC = navVC?.viewControllers[0] as? SearchGroundViewController2
//            
//        }
//        
//        if tabBarIndex == 2 && tabBarController.selectedViewController == viewController {
//            let navVC = viewController as? SoccerNavigationViewController
//            let favoriteVC = navVC?.viewControllers[0] as? FavoriteViewController
//
//        }
//        
//        if tabBarIndex == 3 && tabBarController.selectedViewController == viewController {
//            let navVC = viewController as? SoccerNavigationViewController
//            let scheduleVC = navVC?.viewControllers[0] as? ScheduleViewController2
//        }
//        
//        return true
//    }
//}
