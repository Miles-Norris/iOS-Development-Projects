//
//  CalendarEntryData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

// The main model for a full calendar entry. It has an extension with a list of dummy entrys for now. It also has a collection for each course of the program that will contain all the lessons in that course.
struct CalendarEntry: Identifiable {
    var id = UUID()
    var date: String
    var lessonID: String
    var lessonName: String
    var mainObjective: String
    var codeChallengeName: String
    var wordOfTheDay: String
    var lessonOutline: LessonDescriptor
    var readingDue: [String]?
    var assignmentsDue: [String]?
    var newAssignments: [String]?
}

extension CalendarEntry {
    
    static var calendarEntrys: [CalendarEntry] = [
        CalendarEntry(
            date: "Jan 06",
            lessonID: "SF02",
            lessonName: "Constants, Variables, and Basic Types",
            mainObjective: "Define and use variables and constants.",
            codeChallengeName: "'Name, Age, and Pi' - Basic Constants & Variables",
            wordOfTheDay: "Compiler",
            lessonOutline: LessonOutline.lessonOutlines["Constants, Variables, and Basic Types"]!,
            readingDue: ["Swift Fundamentals 1.3"],
            newAssignments: ["Constants and Variables"]
        ),
        CalendarEntry(
            date: "Jan 07",
            lessonID: "SF03",
            lessonName: "Operators and Control Flow",
            mainObjective: "Use mathematical opeerators, comparison operators, and logical operators. Control application flow.",
            codeChallengeName: "'Colors, Numbers, Letters' - Control Flow, If Statements, Switch Statements",
            wordOfTheDay: "Console",
            lessonOutline: LessonOutline.lessonOutlines["Operators and Control Flow"]!,
            readingDue: ["Swift Fundamentals 1.4", "Swift Funmdamentals 1.5"],
            assignmentsDue: ["Constants and Variables"],
            newAssignments: ["Operators", "Control Flow"]
        ),
        CalendarEntry(
            date: "Jan 08",
            lessonID: "SF04",
            lessonName: "Strings",
            mainObjective: "Use Swift Strings, including creating, combining, and manipulating them.",
            codeChallengeName: "'Introduction Printer, Letter Counter, Number Adder' - String Interpolation, Basic Functions",
            wordOfTheDay: "Syntax",
            lessonOutline: LessonOutline.lessonOutlines["Strings"]!,
            readingDue: ["Swift Fundamental 2.2"],
            assignmentsDue: ["Operators", "Control Flow"],
            newAssignments: ["Strings"]
        )
    ]
    
    static let swiftFundamentals = calendarEntrys.filter { $0.lessonID.hasPrefix("SF") }
    static let tablesAndPersistence = calendarEntrys.filter { $0.lessonID.hasPrefix("TP") }
    static let networkingAndDataStorage = calendarEntrys.filter { $0.lessonID.hasPrefix("ND") }
    static let specialTopics = calendarEntrys.filter { $0.lessonID.hasPrefix("ST") }
    static let fullAppDevelopment = calendarEntrys.filter { $0.lessonID.hasPrefix("FA") }
    static let prototypeAndProjectPlanning = calendarEntrys.filter { $0.lessonID.hasPrefix("PC") }
    static let groupCapstone = calendarEntrys.filter { $0.lessonID.hasPrefix("GC") }
    
    static let sections = ["Swift Fundamentals", "Tables And Persistence", "Networking And Data Storage", "Special Topics", "Full App Development", "Prototype And Project Planning", "Group Capstone"]
}
