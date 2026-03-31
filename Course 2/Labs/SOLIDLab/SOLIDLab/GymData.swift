//
//  GymData.swift
//  SOLIDLab
//
//  Created by Miles Norris on 3/18/26.
//

import Foundation

// Interface Segregation Principle
protocol HasID {
    func fetchID() -> String
}

// Single Responsibility Principle
class Person {
    var name: String
    var age: String
    var weight: String
    
    init(name: String, age: String, weight: String) {
        self.name = name
        self.age = age
        self.weight = weight
    }
}

// Liskov Substitution Principle
class GymMember: Person, HasID {
    var gymId: String
  
    init(gymId: String, name: String, age: String, weight: String) {
        self.gymId = gymId
        super.init(name: name, age: age, weight: weight)
    }
    
    func fetchID() -> String {
        gymId
    }
}

// Liskov Substitution Principle
class Employee: Person, HasID {
    var jobTitle: String
    var employeeId: String
    
    init(jobTitle: String, employeeId: String, name: String, age: String, weight: String) {
        self.jobTitle = jobTitle
        self.employeeId = employeeId
        super.init(name: name, age: age, weight: weight)
    }
    
    func fetchID() -> String {
        employeeId
    }
}

protocol Database {
    func saveData(data: Person)
    func fetchData(id: String) -> Person?
}

extension Database {
    func saveData(data: Person) {
        
    }
    func fetchData(id: String) -> Person? {
        return Person(name: "", age: "", weight: "")
    }
}

class MemberDatabase: Database {
    let current = MemberDatabase()
    var members = [GymMember]()
}

class EmployeeDatabase: Database {
    let current = EmployeeDatabase()
    var employees = [Employee]()
}

// Open/Closed Principle
class DataService {
    let dataService: Database
    
    init(dataService: Database) {
        self.dataService = dataService
    }
    
    func getData(data: HasID) {
        dataService.fetchData(id: data.fetchID())
    }
    
    func saveData(data: Person) {
        dataService.saveData(data: data)
    }
}

// Dependency Inversion Principle
class GymTracker {
    let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func checkIn(person: HasID) {
        dataService.getData(data: person)
        // Check if the person has a valid ID
    }
}
