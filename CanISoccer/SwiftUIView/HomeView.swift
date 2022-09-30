//
//  HomeView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/27.
//

import SwiftUI

struct HomeView: View {
    @State private var time = ""
    var body: some View {
        VStack {
            HomeSearchView()
            
            TextField("시간대를 선택해주세요", text: $time)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            WeatherDescriptionView()
            
            HStack {
                Spacer()
                Text("서울특별시 마포구의 날씨입니다.")
                    .font(.custom(NotoSansKR.medium500.rawValue, size: 18))
                    .padding(.trailing)
            }
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                Spacer()
                Text("운동하기 딱 좋은 온도입니다!")
                    .font(.custom(NotoSansKR.medium500.rawValue, size: 18))
                    .padding(.trailing)
            }
            Spacer()
            
        }//: VSTACK
        .background(Image("layered-waves-haikei"))
        .foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
