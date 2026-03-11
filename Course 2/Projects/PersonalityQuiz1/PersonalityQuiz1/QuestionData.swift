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
    var type: Houses
}

enum ResponseType {
    case single, multiple, ranged
}

enum Houses {
    case gryffindor, slytherin, hufflepuff, ravenclaw
}

@Observable
class QuizManager {
    var selectedAnswers: [String: [Answer]] = [:]
    var result = ""
    
    func selectAnswers(_ answers: [Answer], label: String) {
        selectedAnswers[label] = answers
    }
    
    func calculateResults() {
        var gryffindorPoints = 0
        var ravenclawPoints = 0
        var hufflepuffPoints = 0
        var slytherinPoints = 0
        for houseArr in selectedAnswers.values {
            for animal in houseArr {
                switch animal.type {
                case .gryffindor:
                    gryffindorPoints += 1
                case .ravenclaw:
                    ravenclawPoints += 1
                case .hufflepuff:
                    hufflepuffPoints += 1
                case .slytherin:
                    slytherinPoints += 1
                }
            }
        }
        if max(gryffindorPoints, ravenclawPoints, hufflepuffPoints, slytherinPoints) == gryffindorPoints {
            result = "Gryffindor"
        } else if max(gryffindorPoints, ravenclawPoints, hufflepuffPoints, slytherinPoints) == ravenclawPoints {
            result = "Ravenclaw"
        } else if max(gryffindorPoints, ravenclawPoints, hufflepuffPoints, slytherinPoints) == hufflepuffPoints {
            result = "Hufflepuff"
        } else if max(gryffindorPoints, ravenclawPoints, hufflepuffPoints, slytherinPoints) == slytherinPoints {
            result = "Slytherin"
        } else {
            result = "Gryffindor"
        }
    }
    
    let questionList: [Question] = [
        Question(
            text: "Which quality do you most value in others?",
            type: .single,
            answers: [
                Answer(text: "Loyalty", type: .gryffindor),
                Answer(text: "Intelligence", type: .ravenclaw),
                Answer(text: "Kindness", type: .hufflepuff),
                Answer(text: "Ambition", type: .slytherin)
            ],
            label: "Value"
        ),
        Question(
            text: "Which activities do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Climbing", type: .slytherin),
                Answer(text: "Reading", type: .ravenclaw),
                Answer(text: "Sleeping", type: .hufflepuff),
                Answer(text: "Fighting", type: .gryffindor)
            ],
            label: "Activities"
        ),
        Question(
            text: "How much patience do you have with people?",
            type: .ranged,
            answers: [
                Answer(text: "I get upset quickly", type: .slytherin),
                Answer(text: "I can tolerate them for a bit", type: .ravenclaw),
                Answer(text: "I have a good amount of patience", type: .gryffindor),
                Answer(text: "I can handle anything they got", type: .hufflepuff)
            ],
            label: "Patience"
        ),
        Question(
            text: "Where would you go on vacation?",
            type: .single,
            answers: [
                Answer(text: "Europe", type: .ravenclaw),
                Answer(text: "I Would Rather Stay Home", type: .slytherin),
                Answer(text: "The Mountains", type: .hufflepuff),
                Answer(text: "The Jungle", type: .gryffindor)
            ],
            label: "Vacation"
        ),
        Question(
            text: "How do you usually approach risks?",
            type: .ranged,
            answers: [
                Answer(text: "I avoid them whenever possible", type: .hufflepuff),
                Answer(text: "I consider them carefully first", type: .ravenclaw),
                Answer(text: "I take them if they seem worthwile", type: .slytherin),
                Answer(text: "I jump in boldy", type: .gryffindor)
            ],
            label: "Risks"
        ),
        Question(
            text: "Your teacher assigns a group project. What role do you naturally take?",
            type: .single,
            answers: [
                Answer(text: "The leader", type: .gryffindor),
                Answer(text: "The researcher", type: .ravenclaw),
                Answer(text: "The organizer", type: .hufflepuff),
                Answer(text: "The strategist", type: .slytherin)
            ],
            label: "Class Project"
        ),
        Question(
            text: "What traits describe you?",
            type: .multiple,
            answers: [
                Answer(text: "Daring", type: .slytherin),
                Answer(text: "Curious", type: .ravenclaw),
                Answer(text: "Calm", type: .hufflepuff),
                Answer(text: "Determined", type: .gryffindor)
            ],
            label: "Traits"
        ),
        Question(
            text: "How important is recognition for your acheivments?",
            type: .ranged,
            answers: [
                Answer(text: "I don't care who notices", type: .hufflepuff),
                Answer(text: "It's nice if people notice", type: .ravenclaw),
                Answer(text: "I appreciate recognition", type: .gryffindor),
                Answer(text: "I want my accomplishments to stand out", type: .slytherin)
            ],
            label: "Recognition"
        ),
        Question(
            text: "What motivates you the most?",
            type: .multiple,
            answers: [
                Answer(text: "Achieving success and recognition", type: .slytherin),
                Answer(text: "Learning new things", type: .ravenclaw),
                Answer(text: "Protecting the people you care about", type: .hufflepuff),
                Answer(text: "Proving yourself in difficult situations", type: .gryffindor)
            ],
            label: "Traits"
        ),
        Question(
            text: "How competitive are you?",
            type: .ranged,
            answers: [
                Answer(text: "Not competitive at all", type: .hufflepuff),
                Answer(text: "Slightly competitive", type: .ravenclaw),
                Answer(text: "Competitive in the right situations", type: .gryffindor),
                Answer(text: "Extremely competitive", type: .slytherin)
            ],
            label: "Competitveness"
        )
    ]
}
