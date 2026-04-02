//
//  TodayView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct TodayView: View {
    let date: Date
    @State var viewModel = TodayViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let today = viewModel.currentEntry {
                    CalendarEntryDetailView(currentEntry: today)
                } else {
                    // Text("No Lesson Found For Today")
                    // .foregroundStyle(Color.gray)
                    // .font(.title2)
                    // .bold()
                    // .italic()
                    // .padding(.top, 360)
                    CalendarEntryDetailView(currentEntry: CalendarEntry.calendarEntrys[2])
                }
                Button {
                    viewModel.submitFeedbackPressed()
                } label: {
                    Text("Submit Feedback")
                }
                .padding()
            }
            .frame(maxHeight: .infinity)
        }
        .sheet(isPresented: $viewModel.isFeedbackFormDisplayed) {
            FeedbackFormView()
        }
        .onAppear {
            viewModel.initializeDate(date: date)
        }
    }
}

#Preview {
    TodayView(date: Date())
}
