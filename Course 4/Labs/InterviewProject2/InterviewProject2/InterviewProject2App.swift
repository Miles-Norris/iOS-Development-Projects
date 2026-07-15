//
//  InterviewProject2App.swift
//  InterviewProject2
//
//  Created by Miles Norris on 7/14/26.
//

import SwiftUI

@main
struct InterviewProject2App: App {
    var body: some Scene {
        WindowGroup {
            NewPersonSettingsView(apiService: DataFetcher())
        }
    }
}
