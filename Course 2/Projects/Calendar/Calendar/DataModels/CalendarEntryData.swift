//
//  CalendarEntryData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

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
    
    static var calendarEntrys: [String: CalendarEntry] = [
        "Jan 06": CalendarEntry(
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
        "Jan 07": CalendarEntry(
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
        "Jan 08": CalendarEntry(
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
}
