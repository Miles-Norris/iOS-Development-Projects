//
//  ContentView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarTabView: View {
    
    @State var currentDate: Date = Date()
    @State var dayOfTheMonth: Int = 1
    
    let calendar = Calendar.current
    
    var body: some View {
        TabView {
            TodayView(date: currentDate)
                .tabItem {
                    VStack {
                        Image(systemName: "\(dayOfTheMonth).calendar")
                        Text("Today")
                    }
                }
            
            CalendarView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                }
            
            AssignmentsView()
                .tabItem {
                    VStack {
                        Image(systemName: "text.document")
                        Text("Assignments")
                    }
                }
        }
        .onAppear {
            currentDate = Date()
            dayOfTheMonth = calendar.component(.day, from: currentDate)
        }
    }
}

#Preview {
    CalendarTabView()
}
