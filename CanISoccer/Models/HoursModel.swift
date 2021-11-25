//
//  HoursModel.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/26.
//

import Foundation

struct HoursModel {
    let hours: String
    
    var recommendSunblock: String {
        switch hours {
        case "9:00 오전":
            return "선크림 꼭 발라주세요!"
        case "12:00 오후":
            return "선크림 꼭 발라주세요!"
        case "3:00 오후":
            return "선크림 꼭 발라주세요!"
        case "6:00 오후":
            return "선크림 꼭 발라주세요!"
        default:
            return ""
        }
    }
}
