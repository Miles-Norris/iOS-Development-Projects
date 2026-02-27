//
//  ContentView.swift
//  SubviewsLab
//
//  Created by Miles Norris on 2/27/26.
//

import SwiftUI

struct ContentView: View {
    @State var currentlySelectedSport: String
    @State var sportSubmitted = false
    
    let sports = ["Baseball", "Golf", "Soccer", "Football"]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Favorite Sport")
                .foregroundStyle(Color.white)
                .font(.system(size: 45))
                .bold()
            
            LazyVGrid(columns: [GridItem(spacing: 0), GridItem(spacing: 0)], spacing: 10) {
                ForEach(sports, id: \.self) { sport in
                    SportCellView(currentlySelectedSport: $currentlySelectedSport, sportSubmitted: $sportSubmitted, sportName: sport)
                }
            }
            .padding(.horizontal, 71)
            .padding(.vertical, 100)
            
            Button {
                withAnimation {
                    sportSubmitted = true
                }
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 300, height: 60)
                    .overlay {
                        Text("Submit")
                            .foregroundStyle(Color.white)
                            .font(.title3)
                            .bold()
                    }
            }
            if sportSubmitted {
                Text("You chose \(currentlySelectedSport)!")
                    .foregroundStyle(Color.white)
                    .font(.title3)
                    .bold()
                    .transition(.opacity)
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background {
            Color(.black)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView(currentlySelectedSport: "Baseball")
}
