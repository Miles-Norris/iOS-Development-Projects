//
//  Person.swift
//  MeetMyFamily
//
//  Created by Miles Norris on 2/26/26.
//

import Foundation

struct FamilyMember: Identifiable {
    var id: UUID = UUID()
    var name: String
    var picture: String
    var age: Int
    var birthday: String
    var favoriteColor: String
}

extension FamilyMember {
    static let familyMembers: [FamilyMember] = [
        FamilyMember(
            name: "Tatum",
            picture: "Tatum",
            age: 45,
            birthday: "05/30/1981",
            favoriteColor: "Purple"
        ),
        FamilyMember(
            name: "Ben",
            picture: "Ben",
            age: 43,
            birthday: "08/15/1983",
            favoriteColor: "Orange"
        ),
        FamilyMember(
            name: "Beth",
            picture: "Beth",
            age: 21,
            birthday: "03/21/2005",
            favoriteColor: "Blue"
        ),
        FamilyMember(
            name: "Mary",
            picture: "Mary",
            age: 18,
            birthday: "09/07/2007",
            favoriteColor: "Yellow"
        ),
        FamilyMember(
            name: "Miles",
            picture: "Miles",
            age: 17,
            birthday: "01/04/2009",
            favoriteColor: "Purple"
        ),
        FamilyMember(
            name: "Micah",
            picture: "Micah",
            age: 13,
            birthday: "05/22/2012",
            favoriteColor: "Blue"
        ),
        FamilyMember(
            name: "Annie",
            picture: "Annie",
            age: 12,
            birthday: "01/23/2014",
            favoriteColor: "Red"
        ),
        FamilyMember(
            name: "Callahan",
            picture: "Callahan",
            age: 8,
            birthday: "09/29/2017",
            favoriteColor: "Green"
        ),
        FamilyMember(
            name: "Arwen",
            picture: "Arwen",
            age: 6,
            birthday: "08/17/2019",
            favoriteColor: "Pink"
        )
    ]
}
