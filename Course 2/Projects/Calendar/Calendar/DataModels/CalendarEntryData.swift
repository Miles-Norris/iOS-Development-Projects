//
//  CalendarEntryData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

struct CalendarEntry: Codable, Identifiable, Equatable, Comparable {
    static func < (lhs: CalendarEntry, rhs: CalendarEntry) -> Bool {
        let leftNum: Int = {
            guard let id = lhs.dayID else { return Int.min }
            let suffix = String(id.suffix(2))
            return Int(suffix) ?? Int.min
        }()
        let rightNum: Int = {
            guard let id = rhs.dayID else { return Int.min }
            let suffix = String(id.suffix(2))
            return Int(suffix) ?? Int.min
        }()
        return leftNum < rightNum
    }
    
    var id: UUID
    var date: String
    var holiday: Bool
    var dayID: String?
    var lessonName: String?
    var lessonID: UUID?
    var mainObjective: String?
    var readingDue: String?
    var assignmentsDue: [Assignment]
    var newAssignments: [Assignment]
    var dailyCodeChallengeName: String?
    var wordOfTheDay: String?
    
}

@Observable
class CalendarStore: Equatable {
    
    static func == (lhs: CalendarStore, rhs: CalendarStore) -> Bool {
        lhs.calendarEntries == rhs.calendarEntries
    }
    
    var calendarEntries: [CalendarEntry] = []
    
    var swiftFundamentals: [CalendarEntry] { calendarEntries.filter { $0.dayID?.hasPrefix("SF") == true } }
    var tablesAndPersistence: [CalendarEntry] { calendarEntries.filter { $0.dayID?.hasPrefix("TP") == true } }
    var networkingAndDataStorage: [CalendarEntry] { calendarEntries.filter { $0.dayID?.hasPrefix("ND") == true } }
    var specialTopics: [CalendarEntry] { calendarEntries.filter { $0.dayID?.hasPrefix("ST") == true } }
    var fullAppDevelopment: [CalendarEntry] { calendarEntries.filter { $0.dayID?.hasPrefix("FA") == true } }
    var prototypeAndProjectPlanning: [CalendarEntry] { calendarEntries.filter { $0.dayID?.hasPrefix("PC") == true } }
    var groupCapstone: [CalendarEntry] { calendarEntries.filter { $0.dayID?.hasPrefix("GC") == true } }
    
    static let sections = ["Swift Fundamentals", "Tables And Persistence", "Networking And Data Storage", "Special Topics", "Full App Development", "Prototype And Project Planning", "Group Capstone"]
    
    static func allLessonsSorted(store: CalendarStore) -> [CalendarEntry] {
        var result: [CalendarEntry] = []
        
        result += store.swiftFundamentals.sorted { $0 < $1 }
        result += store.tablesAndPersistence.sorted { $0 < $1 }
        result += store.networkingAndDataStorage.sorted { $0 < $1 }
        result += store.specialTopics.sorted { $0 < $1 }
        result += store.fullAppDevelopment.sorted { $0 < $1 }
        result += store.prototypeAndProjectPlanning.sorted { $0 < $1 }
        result += store.groupCapstone.sorted { $0 < $1 }
        
        return result
    }
}

