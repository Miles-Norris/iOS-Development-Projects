//
//  CalendarSectionSubview.swift
//  Calendar
//
//  Created by Miles Norris on 4/3/26.
//


import SwiftUI

struct CalendarSectionSubview: View {
        let section: [CalendarEntry]
        let sectionTitle: String
    
        let currentUser: User
        var body: some View {
            if !section.isEmpty {
                Text(sectionTitle)
                    .font(.system(size: 30, design: .rounded))
                    .bold()
                    .padding(.vertical)
                    .padding(.top, sectionTitle == "Swift Fundamentals" ? 0 : 15)
                
                // This goes another level deeper into the subviews and creates a CalendarEntrySubview for each lesson in this section.
                ForEach(section) { lesson in
                    NavigationLink(destination: CalendarEntryDetailView(currentEntry: lesson, currentUser: currentUser, viewModel: CalendarEntryDetailViewModel(currentUser: currentUser))) {
                        CalendarEntrySubview(calendarEntry: lesson)
                    }
                    .disabled(lesson.lessonName == nil)
                    .buttonStyle(.plain)
                }
            }
        }
    }
