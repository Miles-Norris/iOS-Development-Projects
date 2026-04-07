//
//  AssignmentData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

// The model for what an assignment is. It has a list of dummy assignments as well a collection of assignments for each course of the program. when the app is opened, and onAppear runs that sorts all of the assignments into their respective course.
struct Assignment: Identifiable {
    var id = UUID()
    var isComplete: Bool
    var dueDate: String
    var assignmentTitle: String
    var assignmentMarkdown: String
}

extension Assignment {
    
    static var assignments: [String: Assignment] = [
        "Constants and Variables" : Assignment(
            isComplete: false,
            dueDate: "Jan 07",
            assignmentTitle: "Constants and Variables",
            assignmentMarkdown: """
        
        # Constants and Variables Lab Requirements - Due Aug 15, 2025
        
        Complete [Lab - Constants and Variables.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/1%20-%20Getting%20Started/2%20-%20Constants,%20Variables,%20and%20Data%20Types/Lab%20-%20Constants%20and%20Variables.playground)
        
        ## Rubric
        
        All lab exercise are complete and correct.
        
        """
        ),
        "Operators": Assignment(
            isComplete: false,
            dueDate: "Jan 08",
            assignmentTitle: "Operators",
            assignmentMarkdown: """
        
        # Operators Lab Requirements - Due Aug 18, 2025
        
        Complete [Lab - Constants and Variables.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/1%20-%20Getting%20Started/2%20-%20Constants,%20Variables,%20and%20Data%20Types/Lab%20-%20Constants%20and%20Variables.playground)
        
        ## Rubric
        
        All lab exercises are complete and correct.
        
        """
        ),
        "Control Flow": Assignment(
            isComplete: false,
            dueDate: "Jan 08",
            assignmentTitle: "Control Flow",
            assignmentMarkdown: """
        
        # Control Flow Lab Requirements - Due Aug 18, 2025
        
        Complete [Lab - Control Flow.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/1%20-%20Getting%20Started/4%20-%20Control%20Flow/Lab%20-%20Control%20Flow.playground)
        
        ## Rubric
        
        All lab exercises are complete and correct.
        
        """
        ),
        "Strings": Assignment(
            isComplete: false,
            dueDate: "Jan 09",
            assignmentTitle: "Strings",
            assignmentMarkdown: """
        
        # Strings Lab Requirements - Due Aug 19, 2025
        
        Complete [Lab - Strings.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/2%20-%20Introduction%20to%20UIKit/1%20-%20Strings/Lab%20-%20Strings.playground)
        
        ## Rubric
        
        All lab exercises are complete and correct.
        
        """
        )
    ]
    
    static var SFassignments: [Assignment] = []
    static var TPassignments: [Assignment] = []
    static var NDassignments: [Assignment] = []
    static var STassignments: [Assignment] = []
    static var FAassignments: [Assignment] = []
    static var PCassignments: [Assignment] = []
    static var GCassignments: [Assignment] = []
    
    static func filterAssignments() {
        SFassignments.removeAll()
        TPassignments.removeAll()
        NDassignments.removeAll()
        STassignments.removeAll()
        FAassignments.removeAll()
        PCassignments.removeAll()
        GCassignments.removeAll()
        for lesson in CalendarEntry.calendarEntrys {
            if let lessonAssignments = lesson.newAssignments {
                for assignment in lessonAssignments {
                    switch lesson.lessonID.prefix(2) {
                    case "SF":
                        SFassignments.append(Assignment.assignments[assignment]!)
                    case "TP":
                        TPassignments.append(Assignment.assignments[assignment]!)
                    case "ND":
                        NDassignments.append(Assignment.assignments[assignment]!)
                    case "ST":
                        STassignments.append(Assignment.assignments[assignment]!)
                    case "FA":
                        FAassignments.append(Assignment.assignments[assignment]!)
                    case "PC":
                        PCassignments.append(Assignment.assignments[assignment]!)
                    case "GC":
                        GCassignments.append(Assignment.assignments[assignment]!)
                    default:
                        return
                    }
                }
            }
        }
    }
}
