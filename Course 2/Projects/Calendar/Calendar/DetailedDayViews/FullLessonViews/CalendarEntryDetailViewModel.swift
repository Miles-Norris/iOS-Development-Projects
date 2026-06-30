//
//  CalendarEntryDetailViewModel.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

@Observable
class CalendarEntryDetailViewModel {
    var assignmentToDisplay: Assignment? = nil
    var isLessonOutlinePresented = false
    var lessonOutlineToPresent: LessonOutline?
    let currentUser: User
     
    init(assignmentToDisplay: Assignment? = nil, isLessonOutlinePresented: Bool = false, lessonOutlineToPresent: LessonOutline? = nil, currentUser: User) {
        self.assignmentToDisplay = assignmentToDisplay
        self.isLessonOutlinePresented = isLessonOutlinePresented
        self.lessonOutlineToPresent = lessonOutlineToPresent
        self.currentUser = currentUser
    }
    
    func assignmentOutlinePressed(_ assignment: Assignment) {
        assignmentToDisplay = assignment
    }
    
    func getLessonOutline(currentEntry: CalendarEntry) async throws {
        do {
            let lessonOutline = try await DataFetcher.shared.fetchData(LessonOutlineAPIRequest(id: currentEntry.lessonID!, secret: currentUser.secret))
            lessonOutlineToPresent = lessonOutline
            isLessonOutlinePresented = true
        } catch {
            print(error.localizedDescription)
            throw APIRequestError.invalidResponse
        }
    }
}
