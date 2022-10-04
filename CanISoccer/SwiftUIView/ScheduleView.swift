//
//  ScheduleView.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/09/27.
//

import SwiftUI

struct ScheduleView: View {
    
    @State var currentDate: Date = Date()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                
                CustomDatePicker(currentDate: $currentDate)
            }//: VSTACK
        }//: ScrollView
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
