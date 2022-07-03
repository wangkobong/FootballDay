//
//  HomeViewModel.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/07/03.
//

import RxSwift
import RxRelay

class HomeViewModel: ViewModelType {
   
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    struct Dependencies {
        let usecase: WeatherUsecase
    }
    
    var disposeBag: DisposeBag = .init()
    
    let dependencies: Dependencies
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
        
}
