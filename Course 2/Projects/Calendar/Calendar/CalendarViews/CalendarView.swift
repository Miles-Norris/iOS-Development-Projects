//
//  CalendarView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarView: View {
    @State var sectionsWithData: [String: [CalendarEntry]] = [:]
    
    // To display all of our lessons, it uses a subview for each course of the program that displays all the lessons in that course
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(CalendarEntry.sections, id: \.self) { section in
                        CalendarSectionSubview(section: sectionsWithData[section] ?? CalendarEntry.swiftFundamentals, sectionTitle: section)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .onAppear {
                sectionsWithData = ["Swift Fundamentals": CalendarEntry.swiftFundamentals, "Tables And Persistence": CalendarEntry.tablesAndPersistence, "Networking And Data Storage": CalendarEntry.networkingAndDataStorage, "Special Topics": CalendarEntry.specialTopics, "Full App Development": CalendarEntry.fullAppDevelopment, "Prototype And Project Planning": CalendarEntry.prototypeAndProjectPlanning, "Group Capstone": CalendarEntry.groupCapstone]
            }
        }
    }
}

#Preview {
    CalendarView()
}
