//
//  User.swift
//  Calendar
//
//  Created by Miles Norris on 6/11/26.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let userUUID: UUID
    let secret: UUID
    let userName: String
}

extension User {
    static let mockUser = User(firstName: "Miles", lastName: "Norris", email: "norrismilesb@gmail.com", userUUID: UUID(), secret: UUID(), userName: "Kilometer")
}
