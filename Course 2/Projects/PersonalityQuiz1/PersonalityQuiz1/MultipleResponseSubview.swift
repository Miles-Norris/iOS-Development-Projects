//
//  MultipleResponseView.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import SwiftUI

struct MultipleResponseSubview: View {
    @Environment(QuizManager.self) var quizManager
    
    let question: Question
    
    @State var answer1 = false
    @State var answer2 = false
    @State var answer3 = false
    @State var answer4 = false
    
    var selectedAnswers: [Answer] {
        var newArr: [Answer] = []
        if answer1 {
            newArr.append(question.answers[0])
        }
        if answer2 {
            newArr.append(question.answers[1])
        }
        if answer3 {
            newArr.append(question.answers[2])
        }
        if answer4 {
            newArr.append(question.answers[3])
        }
        return newArr
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Toggle(question.answers[0].text, isOn: $answer1)
            Toggle(question.answers[1].text, isOn: $answer2)
            Toggle(question.answers[2].text, isOn: $answer3)
            Toggle(question.answers[3].text, isOn: $answer4)
        }
        .font(.custom("ChalkboardSE-bold", size: 20))
        .tint(.cyan)
        .padding(60)
        .onChange(of: selectedAnswers) {
            quizManager.selectAnswers(selectedAnswers, label: question.label)
        }
        .onAppear {
            quizManager.selectAnswers(selectedAnswers, label: question.label)
        }
    }
}

