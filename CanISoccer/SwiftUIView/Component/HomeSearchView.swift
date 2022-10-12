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
    
    /*
        옵저버블 오브젝트는 클래스 프로토콜.
        이 프로토콜을 구현하면 뷰에서 인스턴스의 변화를 감시할 수 있음.
        값이 바뀌면 뷰를 업데이트.
        주로 뷰모델이나 공유데이터를 옵저버블 오브젝트로 구현
     
     */
    /*
        ObservedObject는 속성을 선언할 때 사용하는 특성. 프로퍼티 랩퍼
        ObservableObject 관찰하고 있다가 값이 업데이트 되면 뷰를 업데이트. 속성의 형식은 반드시 ObservableObject를 구현하고 있어야함.
     
     */
    /*
        @Published는 ObservedObject 사용하는 키워드
        속성을 선언할 때 사용하는데, 이렇게 선언한 속성은 다른뷰가 관찰할 수 있음.
        Published 속성을 관찰하고 있다가 값이 바뀌면 뷰를 업데이트 함
     
     */
    
    /*
        ObservedObject와 EnvironmentObject 차이
        ObservedObject는 선언과 동시에 초기화가 가능하고, 만약 다른뷰로 전달하거나 다른뷰로부터 전달받는다면 이니셜라이저가 필요함
        EnvironmentObject는 인스턴스를 만들어서 뷰에 연결하는 방식. 뷰계층을 따라 자동으로 전달되고 속성만 추가해두면 자동으로 초기화되니 이니셜라이저로 받을 필요가 없음
     */

    /*
        전체 과정
        1. VM에서 ObservableObject 프로토콜을 채택하고 관찰할 프로퍼티에 @Published 속성 추가
        2. 뷰에서 @ObservedObject속성으로 VM 인스턴스 저장
        3. AddToList 버튼 클릭시 텍스트 필드에 입력된 텍스트를 VM list 프로퍼티에 추가하면 VM list 프로퍼티가 업데이트
        4. list속성은 @Published 속성으로 선언되어있고 list가 업데이트 되면 새로운 배열을 방출함.
        5. 뷰는 VM인스턴스를 관찰하면서 VM인스턴스에 포함된 프로퍼티가 새로운 값을 방출하면 뷰를 업데이트함.
     */
    
    /*
        @EnvironmentObject
        앱을 만들때 공통적으로 필요한 공유데이터를 공유하기 위해 사용
        Environment 오브젝트를 사용하면 데이터가 뷰계층에 자동으로 주입되기 때문에 쉽게 공유 가능.
        뷰계층이 단순한다면 이니셜라이저로 전달해도 되지만, 뷰계층이 복잡해지면 코드가 필요이상으로 길고 복잡해지기 때문에 Environment 오브젝트를 사용하여 문제해결
     
        Environment 오브젝트는 미리 정의되어 있는 시스템 공유데이터와 커스텀 공유데이터로 구분됨.
        시스템 공유데이터를 사용할 때는 @Environment 키워드를 사용
        커스텀 공유데이터를 사용할 때는 @EnvironmentObject 키워드를 사용
     */
    
    
    // 시스템 공유데이터는 언제든지 바뀔 가능성이 있어 var로 선언
    
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
