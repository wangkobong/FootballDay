//
//  FavoriteModel.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/22.
//

import Foundation

struct Favorite: Identifiable {
    let id = UUID()
    var title: String
    var phoneNumber: String
    var address: String

}

extension Favorite {
    static var preview: [Favorite] {
        return [
            Favorite(title: "서경대 풋살장", phoneNumber: "010-4444-4444", address: "강북구 미아동"),
            Favorite(title: "용산아이파크 풋살장", phoneNumber: "010-4444-4444", address: "용산구 원효로"),
            Favorite(title: "마들스타디움", phoneNumber: "010-4444-4444", address: "노원구 마들로"),
            Favorite(title: "초안산스타디움", phoneNumber: "010-4444-4444", address: "강북구 한천로"),
        ]
    }
}
