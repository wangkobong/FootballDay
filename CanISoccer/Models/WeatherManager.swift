//
//  WeatherManager.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherManager {
    
    static let shared = WeatherManager()
    
    var x = ""
    var y = ""
    
    func fetchGeocoding(address: String, result: @escaping (JSON) -> ())  {
        print(address)
        if let query = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=\(query)"
            let clientID = Bundle.main.naverAPIKEYID
            let clientSecret = Bundle.main.naverAPIKEY
            let header: HTTPHeaders = [
                "X-NCP-APIGW-API-KEY-ID": clientID,
                "X-NCP-APIGW-API-KEY": clientSecret
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case.success(let value):
                    let json = JSON(value)
                    let item = json["addresses"]
                    result(item)

                case.failure(let error):
                    print(error)
                }
            }
            
        }
   
    }
    
    func fetchWeatherForecast(_ latitude: String, _ longitude: String) {
        
        let appid = Bundle.main.openWeatherAPIKEY
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(appid)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                print(json)
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
