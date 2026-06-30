//
//  LessonOutlineData.swift
//  Calendar
//
//  Created by Miles Norris on 3/31/26.
//

import Foundation

struct LessonOutline: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var objectives: [String]
    var schedule: [ScheduleItem]
    var body: String
    var additionalResources: String
}

struct ScheduleItem: Codable, Identifiable, Equatable, Hashable {
    let id: UUID?
    var startTime: ClockTime
    var endTime: ClockTime
    var task: String
}

struct ClockTime: Codable, Equatable, Hashable {
    var hour: Int
    var minute: Int
}

