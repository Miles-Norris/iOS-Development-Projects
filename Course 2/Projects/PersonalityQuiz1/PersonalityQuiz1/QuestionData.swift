//
//  QuestionData.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
    var label: String
}

struct Answer: Identifiable, Hashable {
    var id: UUID = UUID()
    var text: String
    var type: AnimalType
}

enum ResponseType {
    case single, multiple, ranged
}

enum AnimalType {
    case lion, cat, rabbit, turtle
}

@Observable
class QuizManager {
    var selectedAnswers: [String: [Answer]] = [:]
    var result = ""
    
    func selectAnswers(_ answers: [Answer], label: String) {
        selectedAnswers[label] = answers
    }
    func calculateResults() {
        var lionPoints = 0
        var catPoints = 0
        var rabbitPoints = 0
        var turtlePoints = 0
        for animalArr in selectedAnswers.values {
            for animal in animalArr {
                switch animal.type {
                case .lion:
                    lionPoints += 1
                case .cat:
                    catPoints += 1
                case .rabbit:
                    rabbitPoints += 1
                case .turtle:
                    turtlePoints += 1
                }
            }
        }
        if max(lionPoints, catPoints, rabbitPoints, turtlePoints) == lionPoints {
            result = "Lion"
        } else if max(lionPoints, catPoints, rabbitPoints, turtlePoints) == catPoints {
            result = "Cat"
        } else if max(lionPoints, catPoints, rabbitPoints, turtlePoints) == rabbitPoints {
            result = "Rabbit"
        } else if max(lionPoints, catPoints, rabbitPoints, turtlePoints) == turtlePoints {
            result = "Turtle"
        } else {
            result = "Lion"
        }
    }
    
    let questionList: [Question] = [
        Question(
            text: "Which food do you like the most?",
            type: .single,
            answers: [
                Answer(text: "Steak", type: .lion),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrots", type: .rabbit),
                Answer(text: "Corn", type: .turtle)
            ],
            label: "Food"
        ),
        Question(
            text: "Which activities do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .lion)
            ],
            label: "Activities"
        ),
        Question(
            text: "How much do you enjoy car rides?",
            type: .ranged,
            answers: [
                Answer(text: "I dislike them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I love them", type: .lion)
            ],
            label: "Car Rides"
        ),
        Question(
            text: "Where would you go on vacation?",
            type: .single,
            answers: [
                Answer(text: "Europe", type: .cat),
                Answer(text: "The Beach", type: .turtle),
                Answer(text: "Alaska", type: .rabbit),
                Answer(text: "The Jungle", type: .lion)
            ],
            label: "Vacation"
        )
    ]
}
