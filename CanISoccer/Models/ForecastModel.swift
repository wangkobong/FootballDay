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
    @Persisted var tempData: Double
    @Persisted var tempFeelsLikeData: Double
    @Persisted var regDateData: Int
    @Persisted var probabilityOfRain: Double
 
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(predictedTimeUnixData: Double, tempData: Double, tempFeelsLikeData: Double, regDateData: Int, probabilityOfRain: Double) {
        self.init()
        self.predictedTimeUnixData = predictedTimeUnixData
        self.tempData = tempData
        self.tempFeelsLikeData = tempFeelsLikeData
        self.regDateData = regDateData
        self.probabilityOfRain = probabilityOfRain
    }
}
