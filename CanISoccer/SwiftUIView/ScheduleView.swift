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
            .padding(.vertical)
        }//: ScrollView
        // Safe Area View
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button {
                    
                } label: {
                    Text("Add Task")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Orange"), in: Capsule())
                }
                
                Button {
                    
                } label: {
                    Text("Add Remainder")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Purple"), in: Capsule())
                }

            }//: HSTACK
            .padding(.horizontal)
            .padding(.top, 10)
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
