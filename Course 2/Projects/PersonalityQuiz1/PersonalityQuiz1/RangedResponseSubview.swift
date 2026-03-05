//
//  RangedResponseSubview.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import SwiftUI

struct RangedResponseSubview: View {
    @Environment(QuizManager.self) var quizManager
    
    let question: Question
    
    @State var answerValue: Double = 1.0
    
    var selectedAnswer: Answer {
        switch answerValue {
        case 1.0:
            return question.answers[0]
        case 2.0:
            return question.answers[1]
        case 3.0:
            return question.answers[2]
        case 4.0:
            return question.answers[3]
        default:
            return question.answers[0]
        }
    }
    
    var body: some View {
        VStack {
            Slider(value: Binding(get: { Double(Int(answerValue.rounded())) }, set: { newValue in
                        answerValue = Double(Int(newValue.rounded()))
                    }), in: 1...4, step: 1)
            .tint(.cyan)
            HStack {
                Text("\(question.answers[0].text)")
                    .multilineTextAlignment(.center)
                Spacer()
                Text("\(question.answers[1].text)")
                    .multilineTextAlignment(.center)
                Spacer()
                Text("\(question.answers[2].text)")
                    .multilineTextAlignment(.center)
                Spacer()
                Text("\(question.answers[3].text)")
                    .multilineTextAlignment(.center)
            }
            .font(.custom("HoeflerText-Black", size: 12))
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
        .onChange(of: selectedAnswer) {
            quizManager.selectAnswers([selectedAnswer], label: question.label)
        }
        .onAppear {
            quizManager.selectAnswers([selectedAnswer], label: question.label)
        }
    }
}

