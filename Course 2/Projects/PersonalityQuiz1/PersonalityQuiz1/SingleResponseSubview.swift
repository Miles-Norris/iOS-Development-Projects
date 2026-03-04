//
//  SingleResponseView.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import SwiftUI

struct SingleResponseSubview: View {
    @Environment(QuizManager.self) var quizManager
    
    let question: Question
    
    @State var selectedChoice: Answer?
    
    var body: some View {
        VStack(spacing: 10) {
            Picker("\(question.text)", selection: $selectedChoice) {
                ForEach(question.answers) { answer in
                    Text("\(answer.text)")
                        .tag(answer)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 320, height: 200)
        }
        .onChange(of: selectedChoice) {
            if let selectedChoice {
                quizManager.selectAnswers([selectedChoice], label: question.label)
            }
        }
        .onAppear {
            if let selectedChoice {
                quizManager.selectAnswers([selectedChoice], label: question.label)
            }
        }
    }
}
