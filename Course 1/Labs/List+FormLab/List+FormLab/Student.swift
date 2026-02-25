//
//  Student.swift
//  List+FormLab
//
//  Created by Miles Norris on 2/25/26.
//

import Foundation

struct Student: Identifiable {
    var id: UUID = UUID()
    var name: String
    var idNumber: String
    var schoolYear: String
    
    static var schoolYears = ["Freshman", "Sophmore", "Junior", "Senior"]
}
