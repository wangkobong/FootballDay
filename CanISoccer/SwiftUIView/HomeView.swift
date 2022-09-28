//
//  HomeView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/27.
//

import SwiftUI

struct HomeView: View {
    @State private var address = ""
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("내위치클릭")
                } label: {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
               
                
                TextField("주소를 입력해주세요", text: $address)
                    .foregroundColor(.white)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                
                Button {
                    print("내위치클릭")
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 24, height: 24)
                }

            }//: HSTACK
            .frame(height: 50)
            .background()
        }//: VSTACK
        .background(Image("layered-waves-haikei"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
