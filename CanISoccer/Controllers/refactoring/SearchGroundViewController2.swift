//
//  SearchGroundViewController2.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit
import RxSwift

final class SearchGroundViewController2: BaseViewController {
    
    var coordinator: SearchGroundCoordinator?
    
//    let viewModel: SearchGroundViewModel
    
    // MARK: - UI Proteries
    
    private let selfView = SearchGroundView()
    
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
