//
//  AssignmentData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

struct Assignment: Identifiable {
    var id = UUID()
    var isComplete: Bool
    var dueDate: String
    var assignmentMarkdown: String
    
    static var assignments: [String: Assignment] = [
        "Constants and Variables" : Assignment(
            isComplete: false,
            dueDate: "Jan 07",
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
            assignmentMarkdown: """

        # Strings Lab Requirements - Due Aug 19, 2025

        Complete [Lab - Strings.playground](openany://file/open?path=~/Developer/iOS%20Development/Textbook%20Files/2%20-%20Introduction%20to%20UIKit/1%20-%20Strings/Lab%20-%20Strings.playground)

        ## Rubric

        All lab exercises are complete and correct.

        """
        )
    ]
}
