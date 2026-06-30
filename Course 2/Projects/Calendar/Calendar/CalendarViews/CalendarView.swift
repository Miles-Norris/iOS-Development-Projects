//
//  CalendarView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarView: View {
    @Binding var calendarEntryStore: CalendarStore
    
    @State var sectionData: [String: [CalendarEntry]] = [:]
    
    let currentUser: User
    
    var body: some View {
        NavigationStack {
            if calendarEntryStore.calendarEntries.count < 175 {
                ProgressView()
            } else {
                ScrollView {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.accentColor)
                            .font(.system(size: 37))
                        
                        Text("Class Calendar")
                            .bold()
                            .font(.system(size: 42, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    VStack(alignment: .leading) {
                        ForEach(CalendarStore.sections, id: \.self) { section in
                            CalendarSectionSubview(section: sectionData[section] ?? calendarEntryStore.swiftFundamentals, sectionTitle: section, currentUser: currentUser)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .onChange(of: calendarEntryStore.calendarEntries) {
                    calendarEntryStore.calendarEntries = CalendarStore.allLessonsSorted(store: calendarEntryStore)
                }
                .onAppear {
                    sectionData = ["Swift Fundamentals": calendarEntryStore.swiftFundamentals, "Tables And Persistence": calendarEntryStore.tablesAndPersistence, "Networking And Data Storage": calendarEntryStore.networkingAndDataStorage, "Special Topics": calendarEntryStore.specialTopics, "Full App Development": calendarEntryStore.fullAppDevelopment, "Prototype And Project Planning": calendarEntryStore.prototypeAndProjectPlanning, "Group Capstone": calendarEntryStore.groupCapstone]
                    
                    calendarEntryStore.calendarEntries = CalendarStore.allLessonsSorted(store: calendarEntryStore)
                }
            }
        }
    }
}
