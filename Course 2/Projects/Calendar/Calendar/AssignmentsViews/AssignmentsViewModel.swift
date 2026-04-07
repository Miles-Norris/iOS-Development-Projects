//
//  AssignmentsViewModel.swift
//  Calendar
//
//  Created by Miles Norris on 4/7/26.
//

import SwiftUI

@Observable
class AssignmentsViewModel {
    var assignmentToPresent: Assignment?
    var sectionData = ["Swift Fundamentals": Assignment.SFassignments, "Tables And Persistence": Assignment.TPassignments, "Networking And Data Storage": Assignment.NDassignments, "Special Topics": Assignment.STassignments, "Full App Development": Assignment.FAassignments, "Prototype And Project Planning": Assignment.PCassignments, "Group Capstone": Assignment.GCassignments]
}
