////
////  SoccerNavigationViewController.swift
////  CanISoccer
////
////  Created by sungyeon kim on 2022/06/30.
////
//
//import UIKit
//
//final class SoccerNavigationViewController: UINavigationController, UIGestureRecognizerDelegate {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .white
//        appearance.shadowColor = .white
//        
//        interactivePopGestureRecognizer?.delegate = self
//        navigationBar.standardAppearance = appearance
//        navigationBar.compactAppearance = appearance
//        navigationBar.scrollEdgeAppearance = appearance
//
//    }
//    
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count > 1
//    }
//}
