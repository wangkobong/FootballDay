//
//  HomeViewModel.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/07/03.
//

import RxSwift
import RxRelay
import RxCoreLocation

class HomeViewModel: ViewModelType {
   
    
    struct Input {
        let viewDidAppear: Observable<Void>
        let didTapLocation: Observable<Void>
        let didTapSearch: Observable<Void>
        let fetching: Observable<Void>
    }
    
    struct Output {
        let userLocation: Observable<String>
        let weather: Observable<Forecast>
        
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
        
        return Output(userLocation: currentUserLocation.asObservable(), weather: weather.asObservable())
    }
    
    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
        
}
