//
//  ForecastModel.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/22.
//

import Foundation
import RealmSwift

class Forecast: Object {
    
    @Persisted var predictedTimeUnixData: Double
    @Persisted var predictedTimeData: String
    @Persisted var searchedLocationData: String
    @Persisted var tempData: Double
    @Persisted var tempFeelsLikeData: Double
    @Persisted var regDateData: Int
    @Persisted var probabilityOfRain: Double
    @Persisted var weatherIdData: Int
    @Persisted var weatherStatusData: String
 
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(predictedTimeUnixData: Double, predictedTimeData: String, searchedLocationData:String, tempData: Double, tempFeelsLikeData: Double, regDateData: Int, probabilityOfRain: Double, weatherIdData: Int, weatherStatusData: String) {
        self.init()
        self.predictedTimeUnixData = predictedTimeUnixData
        self.predictedTimeData = predictedTimeData
        self.searchedLocationData = searchedLocationData
        self.tempData = tempData
        self.tempFeelsLikeData = tempFeelsLikeData
        self.regDateData = regDateData
        self.probabilityOfRain = probabilityOfRain
        self.weatherIdData = weatherIdData
        self.weatherStatusData = weatherStatusData
    }
    
}


class Ground: Object {
    
    @Persisted var placeNameData: String
    @Persisted var addressData: String
    @Persisted var phoneData: String
    @Persisted var placeURLData: String

 
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(placeNameData: String, addressData: String, phoneData: String, placeURLData: String) {
        self.init()
        self.placeNameData = placeNameData
        self.addressData = addressData
        self.phoneData = phoneData
        self.placeURLData = placeURLData
    }
    
}
