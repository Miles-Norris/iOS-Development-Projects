//
//  ProfileSubview.swift
//  GeometryReaderLab
//
//  Created by Miles Norris on 5/13/26.
//

import SwiftUI

struct ProfileSubview: View {
    let person: Person
    let width: CGFloat
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 100))
            
            Text(person.name)
                .font(.title)
                .bold()
            
            Text(person.description)
                .font(.title3)
                .bold()
        }
        .padding(25)
        .frame(width: width)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brown).opacity(0.2)
        }
    }
}

#Preview {
    ProfileSubview(person: Person(name: "Bill", description: "Single Father"), width: 250)
}
