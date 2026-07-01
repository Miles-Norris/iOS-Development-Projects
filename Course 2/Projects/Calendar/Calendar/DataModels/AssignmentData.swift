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
class AssignmentStore: Equatable {
    static func == (lhs: AssignmentStore, rhs: AssignmentStore) -> Bool {
        lhs.assignments == rhs.assignments
    }
    
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
        let assignmentsByName = Dictionary(uniqueKeysWithValues: assignments.map { ($0.name, $0) })

        for lesson in calendarEntries {
            for assignment in lesson.assignmentsDue {
                guard let detailedAssignment = assignmentsByName[assignment.name] else {
                    continue 
                }
                switch lesson.dayID!.prefix(2) {
                case "SF":
                    SFassignments.append(detailedAssignment)
                case "TP":
                    TPassignments.append(detailedAssignment)
                case "ND":
                    NDassignments.append(detailedAssignment)
                case "ST":
                    STassignments.append(detailedAssignment)
                case "FA":
                    FAassignments.append(detailedAssignment)
                case "PC":
                    PCassignments.append(detailedAssignment)
                case "GC":
                    GCassignments.append(detailedAssignment)
                default:
                    break
                }
            }
        }
    }
}
