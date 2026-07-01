//
//  CalendarTabViewModel.swift
//  Calendar
//
//  Created by Miles Norris on 7/1/26.
//

import Foundation
import SwiftUI

@Observable
class CalendarTabViewModel {
    var currentDate: Date
    var dayOfTheMonth: Int = 1
    
    var todaysEntry: CalendarEntry?
    
    var calendarEntryStore = CalendarStore()
    var assignmentsStore = AssignmentStore()
    
    let currentUser: User
    
    let calendar = Calendar.current
    
    var isFeedbackFormDisplayed = false
    
    init(currentDate: Date, dayOfTheMonth: Int, todaysEntry: CalendarEntry? = nil, calendarEntryStore: CalendarStore = CalendarStore(), assignmentsStore: AssignmentStore = AssignmentStore(), currentUser: User, isFeedbackFormDisplayed: Bool = false) {
        self.currentDate = currentDate
        self.dayOfTheMonth = dayOfTheMonth
        self.todaysEntry = todaysEntry
        self.calendarEntryStore = calendarEntryStore
        self.assignmentsStore = assignmentsStore
        self.currentUser = currentUser
        self.isFeedbackFormDisplayed = isFeedbackFormDisplayed
    }
    
    func assignDates() {
        currentDate = Date()
        dayOfTheMonth = calendar.component(.day, from: currentDate)
    }
    
    func filterAssignments() {
        if calendarEntryStore.calendarEntries.count > 100 {
            assignmentsStore.filterAssignments(calendarEntries: calendarEntryStore.calendarEntries)
        }
    }
    
    func sortLessons() {
        calendarEntryStore.calendarEntries = CalendarStore.allLessonsSorted(store: calendarEntryStore)
    }
    
    func loadData() async throws {
        if calendarEntryStore.calendarEntries.count < 175 {
            do {
                try await initializeData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func initializeData() async throws {
        async let todayResult = DataFetcher.shared.fetchData(
            CalendarEntryAPIRequest(endpoint: "/calendar/today", isReturningArray: false, secret: currentUser.secret)
        )
        async let entriesResult = DataFetcher.shared.fetchData(
            CalendarEntryAPIRequest(endpoint: "/calendar/all", isReturningArray: true, secret: currentUser.secret)
        )
        async let assignmentsResult = DataFetcher.shared.fetchData(
            AssignmentAPIRequest(endpoint: "/assignment/all", isReturningArray: true, secret: currentUser.secret)
        )
        
        let today = try await todayResult as! CalendarEntry
        let allEntries = try await entriesResult as! [CalendarEntry]
        let allAssignments = try await assignmentsResult as! [Assignment]

        var formattedTodayEntry = today
        formattedTodayEntry.date = formatMonthDay(from: formattedTodayEntry.date) ?? ""
        todaysEntry = formattedTodayEntry

        let detailedEntries: [CalendarEntry] = try await withThrowingTaskGroup(of: CalendarEntry?.self) { group in
            for entry in allEntries {
                guard let dayID = entry.dayID, !dayID.isEmpty else { continue }
                group.addTask {
                    var detailed = try await DataFetcher.shared.fetchData(
                        CalendarEntryAPIRequest(endpoint: "/calendar/\(dayID)", isReturningArray: false, secret: self.currentUser.secret)
                    ) as! CalendarEntry
                    detailed.date =  await formatMonthDay(from: detailed.date) ?? ""
                    return detailed
                }
            }

            var collected: [CalendarEntry] = []
            collected.reserveCapacity(allEntries.count)
            for try await maybeEntry in group {
                if let e = maybeEntry {
                    collected.append(e)
                }
            }
            return collected
        }

        let detailedAssignments: [Assignment] = try await withThrowingTaskGroup(of: Assignment?.self) { group in
            for assignment in allAssignments {
                group.addTask {
                    var detailed = try await DataFetcher.shared.fetchData(
                        AssignmentAPIRequest(endpoint: "/assignment/\(assignment.id)", isReturningArray: false, secret: self.currentUser.secret)
                    ) as! Assignment
                    detailed.dueOn = await formatMonthDay(from: detailed.dueOn ?? "") ?? ""
                    return detailed
                }
            }

            var collected: [Assignment] = []
            collected.reserveCapacity(allAssignments.count)
            for try await maybeAssignment in group {
                if let a = maybeAssignment {
                    collected.append(a)
                }
            }
            return collected
        }

        await MainActor.run {
            calendarEntryStore.calendarEntries = detailedEntries
            assignmentsStore.assignments = detailedAssignments
        }
    }
}
