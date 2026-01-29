//
//  Attraction.swift
//  Guidebook
//
//  Created by Miles Norris on 10/15/25.
//

import Foundation

struct Attraction: Identifiable {
    
    var id = UUID()
    var name: String
    var summary: String
    var longDescription: String
    var imageName: String
    var latLong: String
    
}
