//
//  HomeViewModel.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/07/03.
//

import RxSwift
import RxRelay
import RxCoreLocation
import CoreLocation

class HomeViewModel: ViewModelType {
   
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let didTapLocation: Observable<Void>
        let didTapSearch: Observable<Void>
        let fetching: Observable<Void>
    }
    
    struct Output {
        let userLocation: Observable<String>
        let weather: Observable<Forecast>
        let requestLocation: Observable<Void>
        let test: Observable<String>
    }
    
    struct Dependencies {
        let usecase: WeatherUsecase
    }
    
    var disposeBag: DisposeBag = .init()
    
    let dependencies: Dependencies
    
    func transform(input: Input) -> Output {
        
        //MARK: Output Data
        let weather = PublishRelay<Forecast>()
        let currentUserLocation = PublishRelay<String>()
        let coordi = PublishRelay<Void>()
        let test = PublishRelay<String>()
        
        // MARK: - Binds
        input.viewDidLoad
            .flatMap { [unowned self] in testLocation() }
            .bind { result in
                switch result {
                case .authorizedAlways:
                    test.accept("authorizedAlways")
                case .authorizedWhenInUse:
                    test.accept("authorizedWhenInUse")
                case .denied:
                    test.accept("denied")
                case .notDetermined:
                    test.accept("notDetermined")
                case .restricted:
                    test.accept("restricted")
                @unknown default:
                    fatalError()
                }
            }
            .disposed(by: disposeBag)
            
        
            
        
        return Output(userLocation: currentUserLocation.asObservable(), weather: weather.asObservable(), requestLocation: coordi.asObservable(), test: test.asObservable())
    }
    
    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    private func testLocation() -> Observable<CLAuthorizationStatus> {
        return LocationPermissionManager.shared.requestLocation()
    }
        
}
