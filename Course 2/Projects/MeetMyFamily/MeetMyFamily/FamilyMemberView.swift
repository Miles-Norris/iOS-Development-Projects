//
//  SwiftUIView.swift
//  MeetMyFamily
//
//  Created by Miles Norris on 2/26/26.
//

import SwiftUI

struct FamilyMemberView: View {
    @Binding var familyMember: FamilyMember
    @State private var hasBeenDisplayed = false
    @State private var isCurrentlyDisplayed = false
    
    var body: some View {
        VStack {
            
            Image(familyMember.picture)
                .resizable()
                .scaledToFill()
                .cornerRadius(20)
                .frame(width: 160, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 8)
                .padding(.top, 20)
            
            Text("\(hasBeenDisplayed ? "✅" : "") \(familyMember.name)")
                .font(.custom("HiraginoSans-W8", size: 30))
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(1)
        }
        .onTapGesture {
            hasBeenDisplayed = true
            isCurrentlyDisplayed.toggle()
        }
        .sheet(isPresented: $isCurrentlyDisplayed) {
            FamilyMemberDetailView(familyMember: $familyMember)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var familyMember = FamilyMember(name: "Miles", picture: "Miles", age: 17, birthday: "01/04/2009", favoriteColor: "Purple")
    FamilyMemberView(familyMember: $familyMember)
}
