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
    
    @State var todaysEntry: CalendarEntry?
    
    @State var calendarEntryStore = CalendarStore()
    @State var assignmentsStore = AssignmentStore()
    
    let currentUser: User
    
    let calendar = Calendar.current
    
    @State var isFeedbackFormDisplayed = false
    
    var body: some View {
        NavigationStack {
            TabView {
                TodayView(date: currentDate, currentEntry: todaysEntry, viewModel: TodayViewModel(currentUser: currentUser), calendarEntryStore: $calendarEntryStore)
                    .tabItem {
                        VStack {
                            Image(systemName: "\(dayOfTheMonth).calendar")
                            Text("Today")
                        }
                    }
                
                CalendarView(calendarEntryStore: $calendarEntryStore, currentUser: currentUser)
                    .tabItem {
                        VStack {
                            Image(systemName: "calendar")
                            Text("Calendar")
                        }
                    }
                
                AssignmentsView(assignmentsStore: $assignmentsStore, currentUser: currentUser)
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
            .onChange(of: calendarEntryStore.calendarEntries) {
                if calendarEntryStore.calendarEntries.count > 100 {
                    assignmentsStore.filterAssignments(calendarEntries: calendarEntryStore.calendarEntries)
                }
            }
            .task {
                if calendarEntryStore.calendarEntries.count < 175 {
                    do {
                        try await initializeData()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .sheet(isPresented: $isFeedbackFormDisplayed) {
                FeedbackFormView(viewModel: FeedbackFormViewModel(lessonsStore: calendarEntryStore, currentUser: currentUser))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        calendarEntryStore.calendarEntries = CalendarStore.allLessonsSorted(store: calendarEntryStore)
                        isFeedbackFormDisplayed = true
                    } label: {
                        Image(systemName: "info")
                    }
                }
            }
        }
    }
    
    func initializeData() async throws {
        let today = try await DataFetcher.shared.fetchData(CalendarEntryAPIRequest(endpoint: "/calendar/today", isReturningArray: false, secret: currentUser.secret))
        let entries = try await DataFetcher.shared.fetchData(CalendarEntryAPIRequest(endpoint: "/calendar/all", isReturningArray: true, secret: currentUser.secret))
        let assignments = try await DataFetcher.shared.fetchData(AssignmentAPIRequest(endpoint: "/assignment/all", isReturningArray: true, secret: currentUser.secret))
        
        var formattedTodayEntry = today as! CalendarEntry
        formattedTodayEntry.date = formatMonthDay(from: formattedTodayEntry.date) ?? ""
        todaysEntry = formattedTodayEntry
        
        for entry in entries as! [CalendarEntry] {
            if let dayID = entry.dayID {
                var detailedEntry = try await DataFetcher.shared.fetchData(CalendarEntryAPIRequest(endpoint: "/calendar/\(dayID)", isReturningArray: false, secret: currentUser.secret)) as! CalendarEntry
                
                detailedEntry.date = formatMonthDay(from: detailedEntry.date) ?? ""
                calendarEntryStore.calendarEntries.append(detailedEntry)
            }
        }
        
        for assignment in assignments as! [Assignment] {
            let detailedAssignment = try await DataFetcher.shared.fetchData(AssignmentAPIRequest(endpoint: "/assignment/\(assignment.id)", isReturningArray: false, secret: currentUser.secret)) as! Assignment
            
            if let body = detailedAssignment.body {
                print(body)
            }
            assignmentsStore.assignments.append(detailedAssignment)
        }
    }
}

