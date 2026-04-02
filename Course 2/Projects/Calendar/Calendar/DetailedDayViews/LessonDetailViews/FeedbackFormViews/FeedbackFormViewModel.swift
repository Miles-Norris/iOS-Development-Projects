//
//  FeedbackFormViewModel.swift
//  Calendar
//
//  Created by Miles Norris on 4/2/26.
//

import SwiftUI

@Observable
class FeedbackFormViewModel {
    var searchText = ""
    var filteredLessons = CalendarEntry.calendarEntrys
    var selectedLesson: CalendarEntry? = nil
    var whatWentWellText = ""
    var whatWasConfusingText = ""
    var whatSuggestionsText = ""
    
    func allLessonsFiltered() {
        if !searchText.isEmpty {
            filteredLessons = CalendarEntry.calendarEntrys.filter { $0.lessonName.lowercased().contains(searchText.lowercased()) || $0.lessonID.lowercased().contains(searchText.lowercased()) || $0.date.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func searchBarClear() {
        searchText = ""
    }
    
    func lessonSelected(lesson: CalendarEntry) {
        selectedLesson = lesson
    }
    
    func goBack() {
        selectedLesson = nil
    }
}
