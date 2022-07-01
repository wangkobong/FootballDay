//
//  HomeView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    
    // MARK: - UI Properties
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        return label
    }()
    
    
    // MARK: - Configures
    
    override func configureUI() {
        self.backgroundColor = .yellow
        
        addSubview(testLabel)
        testLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
    }
}
