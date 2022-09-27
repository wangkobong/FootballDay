////
////  BaseView.swift
////  CanISoccer
////
////  Created by sungyeon kim on 2022/06/30.
////
//
//import UIKit
//import RxSwift
//
//class BaseView: UIView {
//    var disposeBag = DisposeBag()
//    
//    var shouldTouchesEndEditing: Bool = true
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setUpBindis()
//        configureUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configureUI() {
//        
//    }
//    
//    func setUpBindis() {
//        
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if shouldTouchesEndEditing {
//            endEditing(true)
//        }
//    }
//
//}
