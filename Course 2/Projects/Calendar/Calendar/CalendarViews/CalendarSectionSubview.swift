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
        var body: some View {
            if !section.isEmpty {
                Text(sectionTitle)
                    .font(.system(size: 35))
                    .bold()
                    .padding(.vertical)
                
                // This goes another level deeper into the subviews and creates a CalendarEntrySubview for each lesson in this section.
                ForEach(section) { lesson in
                    NavigationLink(destination: CalendarEntryDetailView(currentEntry: lesson)) {
                        CalendarEntrySubview(calendarEntry: lesson)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
