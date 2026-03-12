//
//  QuestionFlowView.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import SwiftUI

struct QuestionFlowView: View {
    @Environment(QuizManager.self) var quizManager
    @Binding var isPresented: Bool
    
    let question: Question
    var currentQuestionIndex: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(question.text)")
                    .font(.custom("HoeflerText-Black", size: 35))
                    .multilineTextAlignment(.center)
                switch question.type {
                case .single:
                    SingleResponseSubview(question: question)
                case .multiple:
                    MultipleResponseSubview(question: question)
                case .ranged:
                    RangedResponseSubview(question: question)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if quizManager.questionList.count == currentQuestionIndex + 1 {
                        NavigationLink(destination: ResultsView(isPresented: $isPresented)) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 17))
                                .foregroundStyle(Color.primary)
                        }
                    } else {
                        NavigationLink(destination: QuestionFlowView(isPresented: $isPresented, question: quizManager.questionList[currentQuestionIndex + 1], currentQuestionIndex: currentQuestionIndex + 1)) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 17))
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
            }
        }
    }
}
