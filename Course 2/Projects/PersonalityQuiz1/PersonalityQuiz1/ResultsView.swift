//
//  ResultsView.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import SwiftUI

struct ResultsView: View {
    @Environment(QuizManager.self) var quizManager
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 75) {
            Text("You Belong in \(quizManager.result)!")
                .font(.custom("ChalkboardSE-bold", size: 50))
                .multilineTextAlignment(.center)
            Image("\(quizManager.result)")
                .resizable()
                .frame(width: 250, height: 250)
            Button {
                isPresented = false
            } label: {
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 30))
                    .frame(width: 200, height: 75)
                    .foregroundStyle(Color.cyan)
                    .overlay {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 30))
                            .stroke(Color.black, lineWidth: 8)
                        Text("Retake")
                            .font(.custom("ChalkboardSE-bold", size: 35))
                            .padding(.bottom, 10)
                            .foregroundStyle(Color.white)
                    }
            }

        }
        .onAppear {
            quizManager.calculateResults()
        }
    }
}
