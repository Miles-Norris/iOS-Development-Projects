//
//  Hotel_Registration_AppApp.swift
//  Hotel Registration App
//
//  Created by Jane Madsen on 9/26/25.
//

import SwiftUI

@main
struct Hotel_Registration_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(firstName: "", lastName: "", doorCode: "", numberOfGuests: 0, lengthOfStay: 1, nonSmoking: true, registrationFeedback: 0)
        }
    }
}
