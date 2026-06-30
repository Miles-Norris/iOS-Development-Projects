//
//  USRep.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import Foundation

struct USRepResponse: Codable {
    let results: [USRep]
}

struct USRep: Codable, Hashable {
    let name: String
    let party: String
    let state: String
    let district: String
    let phone: String
    let office: String
    let link: String
}

