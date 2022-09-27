//
//  MainView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/26.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("날씨")
                }
            SearchGroundView()
                .tabItem {
                    Image(systemName: "person")
                    Text("구장검색")
                }
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("즐겨찾기")
                }
            
            ScheduleView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("즐겨찾기")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
