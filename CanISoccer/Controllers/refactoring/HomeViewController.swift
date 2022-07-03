//
//  HomeViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit
import RxSwift
import SnapKit

final class HomeViewController: BaseViewController {
    
    var coordinator: HomeCoordinator?
    
//    let viewModel: HomeViewModel
    
    // MARK: - UI Proteries
    
    private let selfView = HomeView()
    
    // MARK: - Lifecycles
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = selfView
    }
    
    // MARK: - Configures
    
    override func configureUI() {
    }
    
    override func setUpBindins() {
        
    }
    
    
}
