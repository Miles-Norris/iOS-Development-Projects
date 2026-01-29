//
//  City.swift
//  Guidebook
//
//  Created by Miles Norris on 10/15/25.
//

import Foundation

struct City: Identifiable {
    
    var id = UUID()
    var name: String
    var summary: String
    var imageName: String
    
    var attractions: [Attraction] 
}
