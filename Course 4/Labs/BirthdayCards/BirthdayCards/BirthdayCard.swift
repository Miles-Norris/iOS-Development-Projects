//
//  Item.swift
//  BirthdayCards
//
//  Created by Miles Norris on 5/18/26.
//

import Foundation
import SwiftUI

struct BirthdayCard: Identifiable {
    var id: UUID = UUID()
    var backgroundColor: Color
    var selectedDate: Date
    var themePhoto: UIImage?
    var partyDescription: String
    
    init(backgroundColor: Color, selectedDate: Date, themePhoto: UIImage? = nil, partyDescription: String) {
        self.backgroundColor = backgroundColor
        self.selectedDate = selectedDate
        self.themePhoto = themePhoto
        self.partyDescription = partyDescription
    }
}
