//
//  TodayView.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

struct TodayView: View {
    let date: Date
    @State var viewModel: TodayViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let today = viewModel.currentEntry {
                    CalendarEntryDetailView(currentEntry: today, viewModel: CalendarEntryDetailViewModel())
                } else {
                    // When the API is implemented and we have every calendar entry this will be a fail safe for any missing days. Right now we just have a placeholder day.
                    // Text("No Lesson Found For Today")
                    // .foregroundStyle(Color.gray)
                    // .font(.title2)
                    // .bold()
                    // .italic()
                    // .padding(.top, 360)
                    CalendarEntryDetailView(currentEntry: CalendarEntry.calendarEntrys[2], viewModel: CalendarEntryDetailViewModel())
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
            FeedbackFormView(viewModel: FeedbackFormViewModel())
        }
        // Runs through all of the calendar entrys to find one that matches today's date, and if it can't currentEntry is nil.
        .onAppear {
            viewModel.initializeDate(date: date)
        }
    }
}

#Preview {
    TodayView(date: Date(), viewModel: TodayViewModel())
}
