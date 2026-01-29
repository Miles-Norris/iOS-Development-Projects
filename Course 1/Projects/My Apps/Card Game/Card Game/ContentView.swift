//
//  ContentView.swift
//  Card Game
//
//  Created by Miles Norris on 12/15/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerCard = "card13"
    @State var cpuCard = "card10"
    @State var playerScore = 0
    @State var cpuScore = 0
    
    var body: some View {
        
        ZStack {
            
            Image("background-plain")
                .aspectRatio(contentMode: .fit)
            
            VStack(spacing : 50) {
                
                Image("logo")
                
                HStack(spacing : 55){
                    Image(playerCard)
                    Image(cpuCard)
                }
                .shadow(radius: 7)
                
                Button() {
                    
                    dealCards()
                    
                } label: {
                    Image("button")
                }
                
                HStack(spacing : 100) {
                    VStack(spacing : 25) {
                        Text("Player")
                            .font(.headline)
                        Text (String(playerScore))
                            .font(.largeTitle)
                    }
                    
                    VStack(spacing : 25) {
                        Text("CPU")
                            .font(.headline)
                        Text (String(cpuScore))
                            .font(.largeTitle)
                    }
                }
                .foregroundStyle(Color(.white))
            }
            
        }
    }
    
    func dealCards() {
        let playerValue = Int.random(in: 2...14)
        let cpuValue = Int.random(in: 2...14)
        
        playerCard = "card" + String(playerValue)
        cpuCard = "card" + String(cpuValue)
        
        if playerValue > cpuValue {
            playerScore += 1
        }
        else if cpuValue > playerValue {
            cpuScore += 1
        }
    }
    
}

#Preview {
    ContentView()
}
