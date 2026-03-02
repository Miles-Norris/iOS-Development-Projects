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
            Text("You are a \(quizManager.result)!")
                .font(.custom("ChalkboardSE-bold", size: 60))
                .multilineTextAlignment(.center)
            Image("\(quizManager.result)")
                .resizable()
                .frame(width: 200, height: 200)
        }
        .onAppear {
            quizManager.calculateResults()
        }
    }
}
