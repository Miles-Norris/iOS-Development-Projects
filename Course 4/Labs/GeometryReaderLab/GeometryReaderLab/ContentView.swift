//
//  ContentView.swift
//  GeometryReaderLab
//
//  Created by Miles Norris on 5/13/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: horizontalSizeClass == .regular ? [GridItem(), GridItem(), GridItem()] : [GridItem(), GridItem()], spacing: 20) {
                        ForEach(Person.people) { person in
                            ProfileSubview(person: person, width: geometry.size.width / (horizontalSizeClass == .regular ? 3 : 2) - 20)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
