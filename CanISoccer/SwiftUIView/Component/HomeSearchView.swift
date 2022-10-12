//
//  HomeSearchView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/29.
//

import SwiftUI

struct HomeSearchView: View {
    
    /*
     State:
     사용자가 상호작용을 통해 상태를 업데이트 하면 UI는 상태에 따라서 자동으로 업데이트 됨
     상태관리가 UIKit보다 비교적 쉽고, UI와 상태가 동기화되지 않는 문제도 거의 발생되지 않는다.
     스유에서는 뷰를 직접 업데이트하지 않는다. 상태를 바꾸면 자동으로 뷰가 업데이트 됨.
     값이 바뀔때마다 UI가 업데이트 되어야 한다면 @State로 변수를 선언.
     
     */
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
