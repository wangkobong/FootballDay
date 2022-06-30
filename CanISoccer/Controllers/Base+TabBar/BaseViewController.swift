//
//  BaseViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    var backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
    
    var coordinatorFinishDelegate: CoordinatorFinishDelegate?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setUpBindins()
        super.viewDidLoad()
        configureNavigationController()
        configureUI()
    }
    
    deinit {
        coordinatorFinishDelegate?.coordinatorDidFinish()
    }
    
    // MARK: - CONFIGURES
    
    func configureUI() {
        
    }
    
    func configureNavigationController() {
        backBarButtonItem.tintColor = .black
//        backBarButtonItem.setTitleTextAttributes([.font: UIFont.suitFont(size: 17, weight: .bold),
//                                                  .foregroundColor: UIColor.black],
//                                                 for: .normal)
        
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func setUpBindins() {
        
    }
    
    //MARK: - HELPERS
    
    func setNavigationShadow() {
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowRadius = 4
        navigationController?.navigationBar.layer.shadowOpacity = 0.18
        navigationController?.navigationBar.layer.shadowOffset = .init(width: 0, height: 0)
    }
}
