//
//  HomeCoordinator.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/06/30.
//

final class HomeCoordinator: Coordinator {
    var delegate: CoordinatorFinishDelegate?
    
    var presenter: SoccerNavigationViewController
    
    var childCoordinators: [Coordinator]
    
    init(presenter: SoccerNavigationViewController) {
        self.presenter = presenter
        childCoordinators = []
    }
    
    func start() {
        let repository = WeatherRepositoryImpl()
        let usecase = WeatherUsecase(repository: repository)
        let viewModel = HomeViewModel(dependencies: .init(usecase: usecase))

        let homeVC = HomeViewController(viewModel: viewModel)
        homeVC.coordinator = self
        homeVC.coordinatorFinishDelegate = self
        self.presenter.setNavigationBarHidden(true, animated: true)
        
        presenter.pushViewController(homeVC, animated: true)
    }
    
    
}
