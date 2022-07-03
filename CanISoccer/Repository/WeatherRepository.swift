//
//  WeatherRepository.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/07/03.
//

import Alamofire

protocol WeatherRepositoryType: AnyObject {
    func fetchGeocoding2()
    func fetchWeatherForecast2()
    func fetchCurrentweather2()
    func fetchSearchPlaces2()
}

final class WeatherRepositoryImpl: WeatherRepositoryType {

    private let service: NetworkService

    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

    func fetchGeocoding2() {
    
    }
    
    func fetchWeatherForecast2() {
        
    }
    
    func fetchCurrentweather2() {
        
    }
    
    func fetchSearchPlaces2() {
        
    }
    
}
