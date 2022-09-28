//
//  HomeSearchView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/29.
//

import SwiftUI

struct HomeSearchView: View {
    @State private var address = ""
    var body: some View {
        HStack {
            Button {
                print("내위치클릭")
            } label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .tint(.white)
            }
           
            
            TextField("", text: $address)
                .placeholder(when: address.isEmpty) {
                    Text("주소를 입력해주세요")
                        .foregroundColor(.black)
                }
                .background(.clear)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
            
            Button {
                print("내위치클릭")
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .tint(.white)
            }

        }//: HSTACK
        .frame(height: 50)
    }
}

struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView()
    }
}
