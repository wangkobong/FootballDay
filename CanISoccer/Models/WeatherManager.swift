//
//  WeatherManager.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import Toast

struct WeatherManager {
    
    static let shared = WeatherManager()

    func fetchGeocoding(address: String, result: @escaping (JSON, Int) -> ())  {
        if let query = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=\(query)"
            let clientID = Bundle.main.naverAPIKEYID
            let clientSecret = Bundle.main.naverAPIKEY
            let header: HTTPHeaders = [
                "X-NCP-APIGW-API-KEY-ID": clientID,
                "X-NCP-APIGW-API-KEY": clientSecret
            ]
            
            AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
                switch response.result {
                case.success(let value):
                    let json = JSON(value)
                    let item = json["addresses"]
                    let code = response.response?.statusCode
                    
                    json["meta"]["totalCount"].intValue == 1 ? result(item, code ?? 400) : result(item, 400)
                    
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func fetchWeatherForecast(_ latitude: String, _ longitude: String, result: @escaping ([JSON], Int) -> ()) {
        
        let appid = Bundle.main.openWeatherAPIKEY
        let totalDataCount = 11
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&cnt=\(totalDataCount)&units=metric&appid=\(appid)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            print("fetchWeatherForecast 웨더매니저 전달받은 좌표: \(latitude), \(longitude)")
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                guard let code = response.response?.statusCode else { return }
                let list = json["list"]
                var listArray:[JSON] = []
                
                for item in list.arrayValue{ 
                    listArray.append(item)
                }
                result(listArray, code)
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCurrentweather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees, result: @escaping (JSON) -> ()) {
        
        let appid = Bundle.main.openWeatherAPIKEY
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(appid)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                result(json)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSearchPlaces() {
        let query = "강북구 풋살장"
        let urlString = "https://dapi.kakao.com/v2/local/search/keyword?query=\(query)"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let url = URL(string: encodedString)
        let Authorization = Bundle.main.kakaoAPIKEY
        let header: HTTPHeaders = [
            "Authorization": Authorization,
        ]
        print(Authorization)
        print(header)
        
        AF.request(url!, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                print(json)
            case.failure(let error):
                print("error: \(error)")
            }
        }
    }
}
