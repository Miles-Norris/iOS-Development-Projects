//
//  Cars.swift
//  TDD Lab
//
//  Created by Miles Norris on 6/5/26.
//

import Foundation

class Car: CustomStringConvertible {
    var year: String
    var make: String
    var model: String
    var engineStarted: Bool = false
    var currentSpeed: Double = 0
    var numberOfDoors: Int
    var description: String {
        "This \(year) \(make) \(model) has \(numberOfDoors) doors."
    }

    init(year: String, make: String, model: String, numberOfDoors: Int) {
        self.year = year
        self.make = make
        self.model = model
        self.numberOfDoors = numberOfDoors
    }
    
    func startEngine() {
        engineStarted = true
    }
   
    func increaseSpeed(_ amount: Double) {
        currentSpeed += amount
    }
    
    func decreaseSpeed(_ amount: Double) {
        currentSpeed -= amount
    }
    
    func stopEngine() {
        engineStarted = false
    }
}
