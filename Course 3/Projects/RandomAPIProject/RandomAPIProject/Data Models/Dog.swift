//
//  Dog.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import Foundation

struct Dog: Codable {
    let message: String
    let status: String
}

struct DogWithName: Identifiable, Codable {
    var id = UUID()
    var name: String
    let apiResult: Dog
}

struct DogDataManager {
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let dogArchiveURL = documentsDirectory.appendingPathComponent("dogs").appendingPathExtension("plist")
    
    static func saveToFile(dogs: [DogWithName]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedGoals = try? propertyListEncoder.encode(dogs)
        
        try? encodedGoals?.write(to: dogArchiveURL, options: .noFileProtection)
    }
    
    static func loadDogsFromFile() -> [DogWithName]? {
        let propertyListDecoder = PropertyListDecoder()
        if let dogData = try? Data(contentsOf: dogArchiveURL),
           let decodedDogs = try? propertyListDecoder.decode([DogWithName].self, from: dogData) {
            return decodedDogs
        } else {
            return nil
        }
    }
}
