//
//  Date++Extension.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/22.
//

import Foundation

extension Date {

    var timestamp: Double {
        timeIntervalSince1970 * 1000
    }
    
    var onlyDate: String {
        get {
            let date = Date()
            let dateformatter = DateFormatter()
            dateformatter.locale = Locale(identifier: "ko_KR")
            dateformatter.timeZone = TimeZone(abbreviation: "KST")
            dateformatter.dateFormat = "yyyyMMdd"
            return dateformatter.string(from: date)
        }
    }
    
    func setTimestamp(unixTime: TimeInterval) -> String {
        let dateformatter = DateFormatter()
        let unixTimeString: String = String(unixTime)
        let unixTimeDouble: Double = Double(unixTimeString) ?? 0.0
        let unixTimeDate: Date = Date(timeIntervalSince1970: unixTimeDouble)
        dateformatter.locale = Locale(identifier: "ko_KR")
        dateformatter.timeZone = TimeZone(abbreviation: "KST")
        dateformatter.dateFormat = "MMM d, h:mm a"
        return dateformatter.string(from: unixTimeDate)
    }
    

    func dateToString(unixTime: Double) -> String {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ko_KR")
        dateformatter.timeZone = TimeZone(abbreviation: "KST")
        dateformatter.dateFormat = "MMM d, h:mm a"
        let unixTimeToDate = Date(timeIntervalSince1970: unixTime)
        return dateformatter.string(from: unixTimeToDate)
    }
}
