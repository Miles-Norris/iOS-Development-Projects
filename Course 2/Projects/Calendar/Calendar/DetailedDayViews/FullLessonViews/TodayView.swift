//
//  TodayView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct TodayView: View {
    let date: Date
    let currentEntry: CalendarEntry?
    @State var viewModel: TodayViewModel
    @Binding var calendarEntryStore: CalendarStore
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let today = currentEntry {
                    CalendarEntryDetailView(currentEntry: today, currentUser: viewModel.currentUser, viewModel: CalendarEntryDetailViewModel(currentUser: viewModel.currentUser))
                    
                } else {
                    Text("No Lesson Found For Today")
                    .foregroundStyle(Color.gray)
                    .font(.title2)
                    .bold()
                    .italic()
                    .padding(.top, 320)
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

