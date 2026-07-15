//
//  Person.swift
//  InterviewProject2
//
//  Created by Miles Norris on 7/14/26.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [Person]
    let info: Info
}

struct Person: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: DOB
    let registered: Registered
    let phone: String
    let cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.email == rhs.email
    }
}

extension Person: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone

    enum Postcode: Codable {
        case string(String)
        case int(Int)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let intVal = try? container.decode(Int.self) {
                self = .int(intVal)
            } else if let stringVal = try? container.decode(String.self) {
                self = .string(stringVal)
            } else {
                throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Postcode value is neither Int nor String"))
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .int(let v):
                try container.encode(v)
            case .string(let v):
                try container.encode(v)
            }
        }
    }
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable {
    let offset: String
    let description: String
}

struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct DOB: Codable {
    let date: String
    let age: Int
}

struct Registered: Codable {
    let date: String
    let age: Int
}

struct ID: Codable {
    let name: String
    let value: String?
}

struct Picture: Codable {
    let large: URL
    let medium: URL
    let thumbnail: URL
}

struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

extension Person {
    static var dummyPerson: Person = Person(
        gender: "female",
        name: Name(title: "Ms", first: "Venla", last: "Peura"),
        location: Location(
            street: Street(number: 4925, name: "Rotuaari"),
            city: "Ähtäri",
            state: "Satakunta",
            country: "Finland",
            postcode: .int(89734),
            coordinates: Coordinates(latitude: "-29.8361", longitude: "82.0069"),
            timezone: Timezone(offset: "-10:00", description: "Hawaii")
        ),
        email: "venla.peura@example.com",
        login: Login(
            uuid: "fbf17bfa-e301-42df-a393-a57e5bd19d5e",
            username: "bluemouse409",
            password: "monitor",
            salt: "nagkY03o",
            md5: "5d6c5611affe4ef61ec3cb6448b39f89",
            sha1: "eb3361b8d503d6ad7210701f46225505f4be066f",
            sha256: "4b2e88ddab35f0b118ee0ea5d0028fb9cb0e70be55865b64f3e29a97f2b22d42"
        ),
        dob: DOB(date: "1971-06-16T03:36:33.168Z", age: 55),
        registered: Registered(date: "2020-04-22T16:39:27.394Z", age: 6),
        phone: "07-806-839",
        cell: "040-812-71-82",
        id: ID(name: "HETU", value: "NaNNA394undefined"),
        picture: Picture(
            large: URL(string: "https://randomuser.me/api/portraits/women/32.jpg")!,
            medium: URL(string: "https://randomuser.me/api/portraits/med/women/32.jpg")!,
            thumbnail: URL(string: "https://randomuser.me/api/portraits/thumb/women/32.jpg")!
        ),
        nat: "FI"
    )
}
