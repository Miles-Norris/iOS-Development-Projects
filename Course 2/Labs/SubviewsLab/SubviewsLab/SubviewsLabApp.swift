//
//  SubviewsLabApp.swift
//  SubviewsLab
//
//  Created by Miles Norris on 2/27/26.
//

import SwiftUI

@main
struct SubviewsLabApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(currentlySelectedSport: "Baseball")
                .preferredColorScheme(.light)
        }
    }
}
