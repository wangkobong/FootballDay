//
//  ScheduleViewController2.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit
import RxSwift

final class ScheduleViewController2: BaseViewController {
    
    var coordinator: ScheduleCoordinator?
    
//    let viewModel: ScheduleViewModel
    
    // MARK: - UI Proteries
    
    private let selfView = ScheduleView()
    
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
        self.view.backgroundColor = .yellow
    }
    
    override func setUpBindins() {
        
    }
    
    
}
