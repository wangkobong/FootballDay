////
////  Coordinator.swift
////  CanISoccer
////
////  Created by sungyeon kim on 2022/06/30.
////
//
//import UIKit
//
//protocol CoordinatorFinishDelegate {
//    func coordinatorDidFinish()
//    func removeChildCoordinator(_ child: Coordinator)
//}
//
//protocol Coordinator: AnyObject, CoordinatorFinishDelegate {
//    var delegate: CoordinatorFinishDelegate? { get set }
//    
//    var presenter: SoccerNavigationViewController { get set }
//    
//    var childCoordinators: [Coordinator] { get set }
//    
//    func start()
//}
//
//extension Coordinator {
//    func coordinatorDidFinish() {
//        delegate?.coordinatorDidFinish()
//    }
//    
//    func removeChildCoordinator(_ child: Coordinator) {
//        for (index, coordinator) in childCoordinators.enumerated() {
//            if coordinator === child {
//                childCoordinators.remove(at: index)
//                break
//            }
//        }
//    }
//}
