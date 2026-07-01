//
//  ContentView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarTabView: View {
    
    @State var viewModel: CalendarTabViewModel
    
    var body: some View {
        NavigationStack {
            TabView {
                TodayView(date: viewModel.currentDate, currentEntry: viewModel.todaysEntry, viewModel: TodayViewModel(currentUser: viewModel.currentUser), calendarEntryStore: $viewModel.calendarEntryStore, assignmentStore: $viewModel.assignmentsStore)
                    .tabItem {
                        VStack {
                            Image(systemName: "\(viewModel.dayOfTheMonth).calendar")
                            Text("Today")
                        }
                    }
                
                CalendarView(calendarEntryStore: $viewModel.calendarEntryStore, currentUser: viewModel.currentUser, assignmentStore: $viewModel.assignmentsStore)
                    .tabItem {
                        VStack {
                            Image(systemName: "calendar")
                            Text("Calendar")
                        }
                    }
                
                AssignmentsView(assignmentsStore: $viewModel.assignmentsStore, calendarStore: $viewModel.calendarEntryStore, currentUser: viewModel.currentUser)
                    .tabItem {
                        VStack {
                            Image(systemName: "text.document")
                            Text("Assignments")
                        }
                    }
            }
            .onAppear {
                viewModel.assignDates()
            }
            .onChange(of: viewModel.calendarEntryStore.calendarEntries) {
                viewModel.filterAssignments()
                viewModel.sortLessons()
            }
            .task {
                do {
                    try await viewModel.loadData()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .sheet(isPresented: $viewModel.isFeedbackFormDisplayed) {
                FeedbackFormView(viewModel: FeedbackFormViewModel(lessonsStore: viewModel.calendarEntryStore, currentUser: viewModel.currentUser))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.calendarEntryStore.calendarEntries = CalendarStore.allLessonsSorted(store: viewModel.calendarEntryStore)
                        viewModel.isFeedbackFormDisplayed = true
                    } label: {
                        Image(systemName: "info")
                    }
                }
            }
        }
    }
}

