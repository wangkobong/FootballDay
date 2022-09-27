////
////  FavoriteCoordinator.swift
////  CanISoccer
////
////  Created by sungyeon kim on 2022/06/30.
////
//
//final class FavoriteCoordinator: Coordinator {
//    var delegate: CoordinatorFinishDelegate?
//    
//    var presenter: SoccerNavigationViewController
//    
//    var childCoordinators: [Coordinator]
//    
//    init(presenter: SoccerNavigationViewController) {
//        self.presenter = presenter
//        childCoordinators = []
//    }
//    
//    func start() {
////        let service = NetworkService(with: Session(interceptor: Interceptor(interceptors: [AuthorizationInterceptor()])))
////        let repository = UserRepositoryImpl(service: service)
////        let userUsecase = UserUsecase(repository: repository)
////        let viewModel = HomeViewModel(dependencies: .init(userUsecase: userUsecase))
//        let favoriteVC = FavoriteViewController()
//        favoriteVC.coordinator = self
//        favoriteVC.coordinatorFinishDelegate = self
//        
//        presenter.pushViewController(favoriteVC, animated: true)
//    }
//    
//    
//}
