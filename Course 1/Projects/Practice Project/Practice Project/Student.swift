//
//  Student.swift
//  Practice Project
//
//  Created by Miles Norris on 1/15/26.
//

import Foundation

struct Student: Identifiable {
    static var empty: Student {
        Student(firstName: "", lastName: "", seatingPosition: 0, info: StudentInfo(favoriteFood: "", hairColor: ""))
    }
    
    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    var seatingPosition: Int
    var participationCount = 0
    var info: StudentInfo
    
    var seatingPositionString: String {
        get {
            String(seatingPosition)
        } set {
           seatingPosition = Int(newValue) ?? 0
        }
    }
}

struct StudentInfo {
    var favoriteFood: String
    var hairColor: String
    var funFacts: [String] = []
}
