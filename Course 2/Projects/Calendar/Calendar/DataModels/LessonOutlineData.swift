//
//  LessonOutlineData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

protocol LessonDescriptor { }

struct LessonOutline: LessonDescriptor {
    var lessonMarkdown: String
    
    static var lessonOutlines: [String: LessonOutline] = [
        "Constants, Variables, and Basic Types": LessonOutline(lessonMarkdown: """
                ---
                lessonID: SF02
                repeatUntil: 
                lessonName: Constants, Variables, and Basic Types
                folder: 1 - Swift Fundamentals
                ---
                        
                # Constants, Variables, and Basic Types - *Aug 14, 2025*
                        
                | Code Challenge | Word of the Day | Review Topics |
                | - | - | - |
                | 'Name, Age, and Pi' - Basic Constants & Variables | Compiler | Mac Tips |
                        
                ## Schedule
                        
                | | |
                | - | - |
                        
                        
                ## Objectives
                        
                None found.
                        
                ## Lesson Outline
                        
                - Introduce the books and the first lesson
                - Go through the first lesson with the students _Lesson 1.2 Introduction to Swift and Playgrounds_
                  - Complete the exercise and lab in the book with the students. Show students how to turn in the lab to canvas.
                - Teach the second lesson _Lesson 1.3 Constants, Variables, and Data Types_
                Show students how to submit assignments
                        
                ## New Assignments
                        
                - [Constants and Variables](../1%20-%20Swift%20Fundamentals/Assignments/Lab%20-%20Constants%20and%20Variables.md)
                        
                        
                ## Assignments Due Today
                        
                None.
                        
                ## Additional Resources
                        
                None.
                
                """),
        "Operators and Control Flow": LessonOutline(lessonMarkdown: """
                ---
                lessonID: SF03
                repeatUntil: 
                lessonName: Operators and Control Flow
                folder: 1 - Swift Fundamentals
                ---

                # Operators and Control Flow - *Aug 15, 2025*

                | Code Challenge | Word of the Day | Review Topics |
                | - | - | - |
                | 'Colors, Numbers, Letters' - Control Flow, If Statements, Switch Statements | Console | Mac Keyboard Shortcuts |

                ## Schedule

                | | |
                | - | - |
                | 07:30 - 07:50 | Code Challenge |
                | 07:50 - 08:00 | Code Challenge Solution |
                | 08:00 - 08:45 | Lecture |
                | 08:45 - 09:30 | Code Examples |
                | 09:30 - 10:30 | Complete Labs |


                ## Objectives

                - I can use `==`, `>=`, `<=`, `>`, `<`, and `!=` to compare two values and understand the purpose of doing so
                - I can use an `if` statement to control the flow of my code
                - I can use a `switch` statement to control the flow of my code
                - I can perform basic mathematical operations on numeric variables, such as `+`, `-`, `*`, `/`, and `%`
                - I can use ternary operators (`? :`) to condense simple if statements


                ## Lesson Outline

                - Cover _Swift Fundamentals 1.4 - Operators_ and _Swift Fundamentals 1.5 - Control Flow_

                Suggested Activities:
                - The slideshow does not cover modulo (%), so make sure to go over it with students.
                - Instructor writes several if-else and switch statements based on random real world scenarios (e.g. "If hunger > 5, cook meal; else, have snack"); convert an if statement into a switch statement and vice versa; then, have students work in pairs to generate examples of their own.

                ## New Assignments

                - [Operators](../1%20-%20Swift%20Fundamentals/Assignments/Lab%20-%20Operators.md)
                - [Control Flow](../1%20-%20Swift%20Fundamentals/Assignments/Lab%20-%20Control%20Flow.md)


                ## Assignments Due Today

                - [Constants and Variables](../1%20-%20Swift%20Fundamentals/Assignments/Lab%20-%20Constants%20and%20Variables.md)


                ## Additional Resources

                - Old lesson on [Mathematic Operators.](https://github.com/joybob22/Mtech-Lessons/blob/main/Unit%201/3%20-%20Operators.md)
                - Old lesson on [Control Flow](https://github.com/joybob22/Mtech-Lessons/blob/main/Unit%201/4%20-%20Control%20Flow.md)

                """),
        "Strings": LessonOutline(lessonMarkdown: """
                ---
                lessonID: SF04
                repeatUntil: 
                lessonName: Strings
                folder: 1 - Swift Fundamentals
                ---

                # Strings - *Aug 18, 2025*

                | Code Challenge | Word of the Day | Review Topics |
                | - | - | - |
                | 'Introduction Printer, Letter Counter, Number Adder' -  String Interpolation, Basic Functions | Syntax | Xcode Keyboard Shortcuts |

                ## Schedule

                | | |
                | - | - |
                | 07:30 - 07:50 | Code Challenge |
                | 07:50 - 08:00 | Code Challenge Solution |
                | 08:00 - 08:45 | Lecture |
                | 08:45 - 09:30 | Code Examples |
                | 09:30 - 10:30 | Complete Labs |


                ## Objectives

                - I can create `String` variables
                - I can use string interpolation to add data into a `String`.
                - I can compare two strings to see if they are identical using `==` or `!=`
                - I can identify what a function is and what it does
                - I can create a function that takes input parameters and returns a value
                - I can use the `String` type's methods to do things like create a lowercased version of a string, check the presence of a prefix or suffix in a string, or get the count of characters in a string.
                - I can describe what Unicode is and state that Strings can contain any unicode character (including symbols and 😃 emoji)


                ## Lesson Outline

                - Cover _Swift Fundamentals 2.2 - Strings_

                Suggested Activities:
                - Review what a Type is and what the difference is between a variable's type and its value is


                ## New Assignments

                - [Strings](../1%20-%20Swift%20Fundamentals/Assignments/Lab%20-%20Strings.md)


                ## Assignments Due Today

                - [Operators](../1%20-%20Swift%20Fundamentals/Assignments/Lab%20-%20Operators.md)
                - [Control Flow](../1%20-%20Swift%20Fundamentals/Assignments/Lab%20-%20Control%20Flow.md)


                ## Additional Resources

                - Old lesson on [Strings](https://github.com/joybob22/Mtech-Lessons/blob/Unit-2/Unit%202/1%20-%20Strings.md)
                - Old lesson on [Functions](https://github.com/joybob22/Mtech-Lessons/blob/Unit-2/Unit%202/2%20-%20Functions.md)

                """)
    ]
}
