//
//  TodayViewModel.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import SwiftUI

@Observable
class TodayViewModel {
    var formattedDate: String = ""
    
    let currentUser: User
    
    init(formattedDate: String = "", currentUser: User) {
        self.formattedDate = formattedDate
        self.currentUser = currentUser
    }
}
