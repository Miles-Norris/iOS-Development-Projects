//
//  ProfileOptions.swift
//  StacksLab
//
//  Created by Miles Norris on 2/19/26.
//

import Foundation

struct ProfileOptions: Identifiable {
    var id: UUID = UUID()
    var imageName: String
    var optionTitle: String
    
    static let options: [ProfileOptions] = [
        ProfileOptions(
            imageName: "clock.arrow.trianglehead.counterclockwise.rotate.90",
            optionTitle: "History"
        ),
        ProfileOptions(
            imageName: "envelope",
            optionTitle: "Inbox"
        ),
        ProfileOptions(
            imageName: "person.fill",
            optionTitle: "Friends"
        ),
        ProfileOptions(
            imageName: "star.fill",
            optionTitle: "Favorites"
        ),
        ProfileOptions(
            imageName: "gearshape.fill",
            optionTitle: "Settings"
        ),
        ProfileOptions(
            imageName: "cellularbars",
            optionTitle: "Stats"
        ),
        ProfileOptions(
            imageName: "trash",
            optionTitle: "Delete Profile"
        )
    ]
}

