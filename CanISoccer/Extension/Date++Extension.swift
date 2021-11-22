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
    
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            let dateformatter = DateFormatter()
            dateformatter.locale = Locale(identifier: "ko_KR")
            dateformatter.timeZone = TimeZone(abbreviation: "KST")
            return calender.date(from: dateComponents)
        }
    }
}
