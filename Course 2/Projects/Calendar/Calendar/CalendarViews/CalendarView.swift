//
//  CalendarView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct CalendarView: View {
    @State var swiftFundamentals = CalendarEntry.calendarEntrys.filter { $0.lessonID.hasPrefix("SF") }
    @State var tablesAndPersistence = CalendarEntry.calendarEntrys.filter { $0.lessonID.hasPrefix("TP") }
    @State var networkingAndDataStorage = CalendarEntry.calendarEntrys.filter { $0.lessonID.hasPrefix("ND") }
    @State var specialTopics = CalendarEntry.calendarEntrys.filter { $0.lessonID.hasPrefix("ST") }
    @State var fullAppDevelopment = CalendarEntry.calendarEntrys.filter { $0.lessonID.hasPrefix("FA") }
    @State var prototypeAndProjectPlanning = CalendarEntry.calendarEntrys.filter { $0.lessonID.hasPrefix("PC") }
    @State var groupCapstone = CalendarEntry.calendarEntrys.filter { $0.lessonID.hasPrefix("GC") }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if !swiftFundamentals.isEmpty {
                        Text("Swift Fundamentals")
                            .font(.system(size: 35))
                            .bold()
                        
                        ForEach(swiftFundamentals) { lesson in
                            CalendarEntrySubview(calendarEntry: lesson)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    CalendarView()
}
