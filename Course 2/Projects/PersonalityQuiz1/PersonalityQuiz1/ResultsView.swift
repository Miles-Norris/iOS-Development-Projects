//
//  ResultsView.swift
//  PersonalityQuiz1
//
//  Created by Miles Norris on 3/2/26.
//

import SwiftUI

struct ResultsView: View {
    @Environment(QuizManager.self) var quizManager
    
    var body: some View {
        VStack {
            Text("You Belong in \(quizManager.result)!")
                .font(.custom("ChalkboardSE-bold", size: 50))
                .multilineTextAlignment(.center)
            Image("\(quizManager.result)")
                .resizable()
                .frame(width: 250, height: 250)
        }
        .onAppear {
            quizManager.calculateResults()
        }
    }
}
