//
//  ContentView.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import SwiftUI

struct MainView: View {
    let dataFetcher: APIService
    
    @State var dogs: [DogWithName] = []
    var body: some View {
        TabView {
            DogMainView(dataFetcher: dataFetcher, dogs: $dogs)
                .tabItem {
                    VStack {
                        Image(systemName: "dog.fill")
                        Text("Dogs")
                    }
                }
            
            USRepMainView(dataFetcher: dataFetcher)
                .tabItem {
                    VStack {
                        Image(systemName: "person.2")
                        Text("Reps")
                    }
                }
            
            NobelWinnerMainView(dataFetcher: dataFetcher)
                .tabItem {
                    VStack {
                        Image(systemName: "medal.star")
                        Text("Nobel Prizes")
                    }
                }
        }
        .onAppear {
            if let savedDogs = DogDataManager.loadDogsFromFile() {
                dogs = savedDogs
            }
        }
    }
}

#Preview {
    MainView(dataFetcher: DataFetcher())
}
