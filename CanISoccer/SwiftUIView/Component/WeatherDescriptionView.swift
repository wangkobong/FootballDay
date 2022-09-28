//
//  WeatherDescriptionView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/29.
//

import SwiftUI

struct WeatherDescriptionView: View {
    var body: some View {
        HStack {
            Text("16")
                .font(.custom(NotoSansKR.bold700.rawValue, size: 48))
                .padding(.leading)
            Text("℃")
                .font(.custom(NotoSansKR.medium500.rawValue, size: 44))
            Spacer()
            Text("Clouds")
                .font(.custom(NotoSansKR.medium500.rawValue, size: 28))
            Image(systemName: "cloud")
                .font(.custom(NotoSansKR.bold700.rawValue, size: 48))
                .padding(.trailing)
        }//: HSTACK
        .foregroundColor(.white)
    }
}

struct WeatherDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDescriptionView()
    }
}
