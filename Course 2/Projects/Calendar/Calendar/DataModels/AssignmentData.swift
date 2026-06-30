//
//  AssignmentData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

struct Assignment: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var assignmentType: String
    var body: String?
    var assignedOn: String?
    var dueOn: String?
    var userProgress: String?
    var faqs: [FAQ]
}

@Observable
class AssignmentStore {
    
    var assignments: [Assignment] = []
    
    var SFassignments: [Assignment] = []
    var TPassignments: [Assignment] = []
    var NDassignments: [Assignment] = []
    var STassignments: [Assignment] = []
    var FAassignments: [Assignment] = []
    var PCassignments: [Assignment] = []
    var GCassignments: [Assignment] = []
    
    func filterAssignments(calendarEntries: [CalendarEntry]) {
        SFassignments.removeAll()
        TPassignments.removeAll()
        NDassignments.removeAll()
        STassignments.removeAll()
        FAassignments.removeAll()
        PCassignments.removeAll()
        GCassignments.removeAll()
        for lesson in calendarEntries {
            for assignment in lesson.assignmentsDue {
                switch lesson.dayID!.prefix(2) {
                case "SF":
                    SFassignments.append(assignment)
                case "TP":
                    TPassignments.append(assignment)
                case "ND":
                    NDassignments.append(assignment)
                case "ST":
                    STassignments.append(assignment)
                case "FA":
                    FAassignments.append(assignment)
                case "PC":
                    PCassignments.append(assignment)
                case "GC":
                    GCassignments.append(assignment)
                default:
                    return
                }
            }
        }
    }
}
