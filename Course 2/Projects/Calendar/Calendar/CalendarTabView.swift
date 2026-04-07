//
//  ContentView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarTabView: View {
    
    // We use today's date to both initialize the TodayView, and to update the tab item to reflect today's date.
    @State var currentDate: Date
    @State var dayOfTheMonth: Int = 1
    
    let calendar = Calendar.current
    
    var body: some View {
        TabView {
            TodayView(date: currentDate, viewModel: TodayViewModel())
                .tabItem {
                    VStack {
                        Image(systemName: "\(dayOfTheMonth).calendar")
                        Text("Today")
                    }
                }
            
            CalendarView(viewModel: CalendarViewModel())
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                }
            
            AssignmentsView(viewModel: AssignmentsViewModel())
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
            Assignment.filterAssignments()
        }
    }
}

#Preview {
    CalendarTabView(currentDate: Date())
}
