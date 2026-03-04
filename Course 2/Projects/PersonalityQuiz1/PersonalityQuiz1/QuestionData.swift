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
        )
    ]
}
