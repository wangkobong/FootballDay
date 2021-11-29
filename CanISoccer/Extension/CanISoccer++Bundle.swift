//
//  CanISoccer++Bundle.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/20.
//

import Foundation

extension Bundle {
    var naverAPIKEYID: String {
        guard let file = self.path(forResource: K.WeatherInfoPlist, ofType: "plist") else { return ""}
        
        guard let resouce = NSDictionary(contentsOfFile: file) else { return ""}
        guard let key = resouce["X-NCP-APIGW-API-KEY-ID"] as? String else { fatalError("WeatherInfo.plist에 X-NCP-APIGW-API-KEY-ID를 설정해주세요.")}
        return key
    }
    
    var naverAPIKEY: String {
        guard let file = self.path(forResource: K.WeatherInfoPlist, ofType: "plist") else { return ""}
        
        guard let resouce = NSDictionary(contentsOfFile: file) else { return ""}
        guard let key = resouce["X-NCP-APIGW-API-KEY"] as? String else { fatalError("WeatherInfo.plist에 X-NCP-APIGW-API-KEY를 설정해주세요.")}
        return key
    }
    
    var openWeatherAPIKEY: String {
        guard let file = self.path(forResource: K.WeatherInfoPlist, ofType: "plist") else { return ""}
        
        guard let resouce = NSDictionary(contentsOfFile: file) else { return ""}
        guard let key = resouce["openweatherAPIKEY"] as? String else { fatalError("WeatherInfo.plist에 openweatherAPIKEY를 설정해주세요.")}
        return key
    }
    
    var kakaoAPIKEY: String {
        guard let file = self.path(forResource: K.WeatherInfoPlist, ofType: "plist") else { return ""}
        
        guard let resouce = NSDictionary(contentsOfFile: file) else { return ""}
        guard let key = resouce["Authorization"] as? String else { fatalError("WeatherInfo.plist에 Authorization을 설정해주세요.")}
        return key
    }
}

