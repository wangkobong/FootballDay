//
//  FavoriteRow.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/10/03.
//

import SwiftUI

struct FavoriteRow: View {
    
    var favorite: Favorite
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(favorite.title)
                    .font(.title3)
                    .padding(.bottom)
                Text(favorite.address)
                    .font(.caption2)
                Text(favorite.phoneNumber)
                    .font(.footnote)
            }//: VStack
            .padding(.leading)
            
            Spacer()
        }//: HSTACK
    }
}

struct FavoriteRow_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRow(favorite: Favorite(title: "테스트", phoneNumber: "010-1234-1234", address: "서울시 강북구"))
    }
}
