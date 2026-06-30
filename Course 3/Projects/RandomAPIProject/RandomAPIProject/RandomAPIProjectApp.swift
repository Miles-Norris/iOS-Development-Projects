//
//  RandomAPIProjectApp.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import SwiftUI

@main
struct RandomAPIProjectApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(dataFetcher: DataFetcher())
        }
    }
}
