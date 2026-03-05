//
//  ContentView.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import SwiftUI

struct TitleView: View {
    @State private var quizManager = QuizManager()
    @State private var isPresented = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 80) {
                Text("Which Hogwarts House Are You?")
                    .font(.custom("ChalkboardSE-bold", size: 45))
                    .multilineTextAlignment(.center)
                Image("HogwartsCrest")
                    .resizable()
                    .frame(width: 200, height: 200)
                Button {
                    isPresented = true
                } label: {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 30))
                        .frame(width: 200, height: 75)
                        .foregroundStyle(Color.cyan)
                        .overlay {
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 30))
                                .stroke(Color.black, lineWidth: 8)
                            Text("Begin")
                                .font(.custom("ChalkboardSE-bold", size: 35))
                                .padding(.bottom, 10)
                                .foregroundStyle(Color.white)
                        }
                }
            }
            .navigationDestination(isPresented: $isPresented) {
                QuestionFlowView(isPresented: $isPresented, question: quizManager.questionList[0], currentQuestionIndex: 0)
            }
        }
        .environment(quizManager)
    }
}

#Preview {
    TitleView()
}
