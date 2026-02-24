//
//  ContentView.swift
//  StacksLab
//
//  Created by Miles Norris on 2/19/26.
//

import SwiftUI

struct ContentView: View {
    @State var options = ProfileOptions.options
    
    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()
                .opacity(0.2)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .bold()
                        .frame(width: 35, height: 30)
                        .padding(.horizontal, 35)
                    Spacer()
                    Text("Edit")
                        .bold()
                        .font(.title2)
                        .padding(.horizontal, 35)
                }
                HStack(spacing: 40) {
                    Image("blankProfile")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                    Text("Username")
                        .font(.largeTitle)
                        .bold()
                }
                .padding(35)
                Spacer()
                List {
                    ForEach(options) { option in
                        HStack {
                            Image(systemName: option.imageName)
                            Text("\(option.optionTitle)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
