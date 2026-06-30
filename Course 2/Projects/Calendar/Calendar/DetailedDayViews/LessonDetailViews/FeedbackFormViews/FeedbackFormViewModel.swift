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
    var lessonsStore: CalendarStore
    var filteredLessons: [CalendarEntry]
    var selectedLesson: CalendarEntry? = nil
    var whatWentWellText = ""
    var whatWasConfusingText = ""
    var whatSuggestionsText = ""
    
    let currentUser: User
    
    init(searchText: String = "", lessonsStore: CalendarStore, selectedLesson: CalendarEntry? = nil, whatWentWellText: String = "", whatWasConfusingText: String = "", whatSuggestionsText: String = "", currentUser: User) {
        self.searchText = searchText
        self.lessonsStore = lessonsStore
        self.selectedLesson = selectedLesson
        self.whatWentWellText = whatWentWellText
        self.whatWasConfusingText = whatWasConfusingText
        self.whatSuggestionsText = whatSuggestionsText
        self.currentUser = currentUser
        self.filteredLessons = CalendarStore.allLessonsSorted(store: lessonsStore).filter { $0.lessonName != nil }
    }
    
    func allLessonsFiltered() {
        if !searchText.isEmpty {
            filteredLessons = lessonsStore.calendarEntries.filter { ($0.lessonName ?? "").lowercased().contains(searchText.lowercased()) || ($0.dayID ?? "").lowercased().contains(searchText.lowercased()) || $0.date.lowercased().contains(searchText.lowercased()) && $0.lessonName != nil }
        } else {
            filteredLessons = CalendarStore.allLessonsSorted(store: lessonsStore).filter { $0.lessonName != nil }
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
    
    func submitLessonFeedback() async throws {
        let feedback = "What Went Well: \(whatWentWellText) \n What Was Confusing: \(whatWasConfusingText) \n What Suggestions Do You Have: \(whatSuggestionsText)"
        
        if let selectedLesson {
            do {
                let _ = try await DataFetcher.shared.fetchData(LessonFeedbackAPIRequest(secret: currentUser.secret, body: LessonFeedbackBody(lessonID: selectedLesson.lessonID ?? UUID(), feedback: feedback)))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
