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
    
    func lessonOutlinePressed() {
        isLessonOutlinePresented = true
    }
    
    func assignmentOutlinePressed(_ assignment: Assignment) {
        assignmentToDisplay = assignment
    }
}
