//
//  AssignmentData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

protocol Completable {
    var isComplete: Bool { get set }
}

struct Assignment: Identifiable, Completable {
    var id = UUID()
    var isComplete: Bool
    var dueDate: String
    var assignmentMarkdown: String
    
    static var assignments: [String: Assignment] = [
        "Constants and Variables" : Assignment(
            isComplete: false,
            dueDate: "Jan 07",
            assignmentMarkdown: """
        ---
        id: 05A2B92D-0536-4C00-B9F3-561DDD77E737
        name: Constants and Variables
        type: lab
        assignDay: SF02
        dueDay: SF03
        location: pg 46
        ---
        
        # Constants and Variables Lab Requirements - Due Aug 15, 2025
        
        Complete [Lab - Constants and Variables.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/1%20-%20Getting%20Started/2%20-%20Constants,%20Variables,%20and%20Data%20Types/Lab%20-%20Constants%20and%20Variables.playground)
        
        ## Rubric
        
        All lab exercise are complete and correct.
        
        """
        ),
        "Operators": Assignment(
            isComplete: false,
            dueDate: "Jan 08",
            assignmentMarkdown: """
        ---
        id: 1F2B12DD-BF66-44E2-992B-725AA0602BA0
        name: Operators
        type: lab
        assignDay: SF03
        dueDay: SF04
        location: pg 56
        ---

        # Operators Lab Requirements - Due Aug 18, 2025

        Complete [Lab - Constants and Variables.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/1%20-%20Getting%20Started/2%20-%20Constants,%20Variables,%20and%20Data%20Types/Lab%20-%20Constants%20and%20Variables.playground)

        ## Rubric

        All lab exercises are complete and correct.

        """
        ),
        "Control Flow": Assignment(
            isComplete: false,
            dueDate: "Jan 08",
            assignmentMarkdown: """
        ---
        id: E202BC1B-6B7E-48AF-A695-9B416628FF26
        name: Control Flow
        type: lab
        assignDay: SF03
        dueDay: SF04
        location: pg 72
        ---

        # Control Flow Lab Requirements - Due Aug 18, 2025

        Complete [Lab - Control Flow.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/1%20-%20Getting%20Started/4%20-%20Control%20Flow/Lab%20-%20Control%20Flow.playground)

        ## Rubric

        All lab exercises are complete and correct.

        """
        ),
        "Strings": Assignment(
            isComplete: false,
            dueDate: "Jan 09",
            assignmentMarkdown: """
        ---
        id: 2DEF1DC3-3DE0-40F1-B23E-2430BECC0F20
        name: Strings
        type: lab
        assignDay: SF04
        dueDay: SF05
        location: pg 191
        ---

        # Strings Lab Requirements - Due Aug 19, 2025

        Complete [Lab - Strings.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/2%20-%20Introduction%20to%20UIKit/1%20-%20Strings/Lab%20-%20Strings.playground)

        ## Rubric

        All lab exercises are complete and correct.

        """
        )
    ]
}
