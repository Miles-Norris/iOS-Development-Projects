//
//  ContentView.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import SwiftUI

struct TitleView: View {
    @State var quizManager = QuizManager()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 80) {
                Text("Which Hogwarts House Are You?")
                    .font(.custom("ChalkboardSE-bold", size: 45))
                    .multilineTextAlignment(.center)
                Image("HogwartsCrest")
                    .resizable()
                    .frame(width: 200, height: 200)
                NavigationLink(destination: QuestionFlowView(question: quizManager.questionList[0], currentQuestionIndex: 0)) {
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
        }
        .environment(quizManager)
    }
}

#Preview {
    TitleView()
}
