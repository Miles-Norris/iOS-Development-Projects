//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Miles Norris on 4/7/26.
//

import SwiftUI

@Observable
class CalendarViewModel {
    var sectionData = ["Swift Fundamentals": CalendarEntry.swiftFundamentals, "Tables And Persistence": CalendarEntry.tablesAndPersistence, "Networking And Data Storage": CalendarEntry.networkingAndDataStorage, "Special Topics": CalendarEntry.specialTopics, "Full App Development": CalendarEntry.fullAppDevelopment, "Prototype And Project Planning": CalendarEntry.prototypeAndProjectPlanning, "Group Capstone": CalendarEntry.groupCapstone]
}
