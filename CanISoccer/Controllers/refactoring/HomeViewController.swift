////
////  HomeViewController.swift
////  CanISoccer
////
////  Created by sungyeon kim on 2022/06/30.
////
//
//import UIKit
//import RxSwift
//import RxCocoa
//
//final class HomeViewController: BaseViewController {
//    
//    var coordinator: HomeCoordinator?
//    
//    let viewModel: HomeViewModel
//    
//    // MARK: - UI Proteries
//    
//    private let selfView = HomeView()
//    
//    // MARK: - Lifecycles
//    
//    init(viewModel: HomeViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func loadView() {
//        self.view = selfView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    
//       
////        LocationPermissionManager.shared.locationSubject
////          .compactMap { $0 }
////          .bind { [weak self] in print( "\($0)" )}
////          .disposed(by: self.disposeBag)
//    }
//    
//    // MARK: - Configures
//    
//    override func configureUI() {
//    }
//    
//    override func setUpBindins() {
//        
//        // MARK: - INPUT
//        let fetching = rx.viewWillAppear.map { _ in }
//        let tapLocation = selfView.locationButton.rx.tap.asObservable()
//        let tapSearch = selfView.searchButton.rx.tap.asObservable()
//        
//        // MARK: - BINDS
//        
//        tapSearch.bind { _ in
//            print("tapSearch")
//        }
//        .disposed(by: disposeBag)
//        
//        tapLocation.bind { _ in
//            print("tapLocation")
//        }
//        .disposed(by: disposeBag)
//        
//        // MARK: - OUTPUT
//        
//        let output = viewModel.transform(input: .init(viewDidLoad: rx.viewDidAppear.map { _ in }.asObservable(), didTapLocation: tapLocation.asObservable(), didTapSearch: tapSearch.asObservable(), fetching: fetching.asObservable()))
//        
//        output.test
//            .take(1)
//            .subscribe {
//                print($0.element)
//            }
//            .disposed(by: disposeBag)
//        
//    }
//    
//    
//}
