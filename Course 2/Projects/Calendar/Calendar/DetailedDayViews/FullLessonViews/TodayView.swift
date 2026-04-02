//
//  TodayView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct TodayView: View {
    let date: Date
    @State var formattedDate: String = ""
    var body: some View {
        ScrollView {
            VStack {
                if let today = CalendarEntry.calendarEntrys[formattedDate] {
                    CalendarEntryDetailView(currentEntry: today)
                } else {
                    // Text("No Lesson Found For Today")
                    // .foregroundStyle(Color.gray)
                    // .font(.title2)
                    // .bold()
                    // .italic()
                    // .padding(.top, 360)
                    CalendarEntryDetailView(currentEntry: CalendarEntry.calendarEntrys["Jan 08"]!)
                }
            }
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            formattedDate = date.formatted(.dateTime.month(.abbreviated).day(.twoDigits))
        }
    }
}

#Preview {
    TodayView(date: Date())
}
