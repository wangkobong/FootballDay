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
                    Image(systemName: "location.fill")
                    Text("날씨")
                }
            SearchGroundView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("구장검색")
                }
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("즐겨찾기")
                }
            
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("일정")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
