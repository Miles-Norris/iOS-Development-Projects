//
//  TodayViewModel.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

@Observable
class TodayViewModel {
    var formattedDate: String = ""
    var currentEntry: CalendarEntry? = nil
    var isFeedbackFormDisplayed = false
    
    func initializeDate(date: Date) {
        formattedDate = date.formatted(.dateTime.month(.abbreviated).day(.twoDigits))
        
        for entry in CalendarEntry.calendarEntrys {
            if entry.date == formattedDate {
                currentEntry = entry
                break
            }
        }
    }
    
    func submitFeedbackPressed() {
        isFeedbackFormDisplayed = true
    }
}
