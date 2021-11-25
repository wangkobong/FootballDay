//
//  InfoModel.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/26.
//

import Foundation

struct InfoModel {
    let feelsLikeTemperature: Int
    
    var conditionTemperature: String {
        switch feelsLikeTemperature {
        case -50 ... -10:
            return "부상이 염려되는 날씨입니다. 다음에 플레이 하시는게 어떨까요?😂"
        case -9 ... -5:
            return "넥워머와 장갑 필수! 웜업도 잊지마세요🏋️"
        case -5 ... 2:
            return "장갑 꼭 끼시고 부상방지를 위한 준비운동 잊지마세요!"
        case 3...10:
            return "긴팔에 타이즈 추천드립니다! 쉬는 동안 입을 외투 잊지마세요!"
        case 11...15:
            return "긴팔에 반바지 추천드립니다! 쉬는 동안 입을 외투 잊지마세요!"
        case 16...23:
            return "운동하기 딱 좋은 온도네요! VAM⚽️S!"
        case 24...28:
            return "날이 덥습니다! 물이나 스포츠음료 충분히 챙기세요!"
        case 31...34:
            return "공을 차기엔 기온이 높습니다. 다음에 플레이 하시는게 어떨까요?😂"
        case 35...100:
            return "폭염경보입니다. 야외활동을 자제해주세요 😭"
        default:
            return "cloud"
        }
    }
}

