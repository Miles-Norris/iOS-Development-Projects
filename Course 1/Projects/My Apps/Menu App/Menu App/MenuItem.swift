//
//  MenuItem.swift
//  Menu App
//
//  Created by Miles Norris on 10/7/25.
//

import Foundation

struct MenuItem: Identifiable {
    
    var id: UUID  = UUID()
    var name:String
    var price:String
    var imageName:String
}
