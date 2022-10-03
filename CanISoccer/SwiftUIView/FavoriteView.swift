//
//  FavoriteView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/27.
//

import SwiftUI

struct FavoriteView: View {
    let favorites = [
        Favorite(title: "서경대 풋살장", phoneNumber: "010-4444-4444", address: "강북구 미아동"),
        Favorite(title: "용산아이파크 풋살장", phoneNumber: "010-4444-4444", address: "용산구 원효로"),
        Favorite(title: "마들스타디움", phoneNumber: "010-4444-4444", address: "노원구 마들로"),
        Favorite(title: "초안산스타디움", phoneNumber: "010-4444-4444", address: "강북구 한천로")
    ]
    
    var body: some View {
        List {
            Section {
                ForEach(favorites, id: \.id) { favorite in
                    FavoriteRow(favorite: favorite)
                }
            } header: {
                Text("FAVORITE GROUNDS")
            }

        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
