//
//  NobelWinner.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import Foundation

struct NobelWinner: Codable {
    let prizes: [Prize]
}

struct Prize: Codable, Hashable {
    let year: String
    let category: String
    let laureates: [Laureate]
}

struct Laureate: Codable, Hashable {
    let id: String
    let firstname: String
    let surname: String
    let motivation: String
    let share: String
}


