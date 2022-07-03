//
//  WeatherUsecase.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/07/03.
//

import Foundation
import RxSwift

class WeatherUsecase {
    private let repository: WeatherRepositoryImpl
    
    init(repository: WeatherRepositoryImpl) {
        self.repository = repository
    }
}
