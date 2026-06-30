//
//  TDD_LabTests.swift
//  TDD LabTests
//
//  Created by Miles Norris on 6/5/26.
//

import Testing
@testable import TDD_Lab

struct CarTest {
    let car = Car(year: "2024", make: "Hyundai", model: "Elantra", numberOfDoors: 4)

    @Test func engineStarts() {
        car.currentSpeed = 0
        car.engineStarted = false
        #expect(car.engineStarted == false)
        #expect(car.currentSpeed == 0)
        car.startEngine()
        #expect(car.engineStarted == true)
    }
    
    @Test func speedIncreaces() {
        car.currentSpeed = 0
        let initialSpeed = car.currentSpeed
        #expect(car.currentSpeed == initialSpeed)
        car.increaseSpeed(25)
        #expect(car.currentSpeed == initialSpeed + 25)
    }
    
    @Test func speedDecreases() {
        car.currentSpeed = 25
        let initialSpeed = car.currentSpeed
        #expect(car.currentSpeed == initialSpeed)
        car.decreaseSpeed(25)
        #expect(car.currentSpeed == initialSpeed - 25 || car.currentSpeed == 0)
        #expect(car.currentSpeed >= 0)
    }

    @Test func engineStops() {
        car.engineStarted = true
        car.currentSpeed = 0
        #expect(car.engineStarted == true)
        #expect(car.currentSpeed == 0)
        car.stopEngine()
        #expect(car.engineStarted == false)
    }
}
