//
//  SearchGroundView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/27.
//

import SwiftUI
import MapKit

struct SearchGroundView: View {
    
    @State private var address = ""
    @State private var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 40.83834587046632,
                        longitude: 14.254053016537693),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.03,
                        longitudeDelta: 0.03))
    @State private var ground = "futsal"
    var grounds = ["futsal", "soccer"]
                    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("내위치클릭")
                } label: {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .tint(.black)
                        .padding(.leading)
                        .padding(.trailing)
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
                        .tint(.black)
                        .padding(.leading)
                        .padding(.trailing)
                }

            }//: HSTACK
            .frame(height: 50)
            Picker("어느 경기장을 검색하시겠습니까?", selection: $ground) {
                         ForEach(grounds, id: \.self) {
                             Text($0)
                         }
                     }
                     .pickerStyle(.segmented)
            Map(coordinateRegion: $region)
        }//: VSATCK
    }
}

struct SearchGroundView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGroundView()
    }
}
