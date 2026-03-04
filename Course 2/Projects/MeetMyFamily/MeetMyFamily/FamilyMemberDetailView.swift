//
//  FamilyMemberDetailView.swift
//  MeetMyFamily
//
//  Created by Miles Norris on 2/26/26.
//

import SwiftUI

struct FamilyMemberDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var familyMember: FamilyMember
    var body: some View {
        VStack(alignment: .leading) {
            
            Image(familyMember.picture)
                .resizable()
                .scaledToFill()
                .frame(width: 410, height: 500)
                .clipShape(Rectangle())

            Text(familyMember.name)
                .font(.custom("HiraginoSans-W8", size: 40))
                .padding(.horizontal, 30)
                .padding(.top, 20)
            Text("Age: \(familyMember.age)")
                .font(.custom("HiraginoSans-W8", size: 20))
                .padding(.horizontal, 30)
            Text("Birthday: \(familyMember.birthday)")
                .font(.custom("HiraginoSans-W8", size: 20))
                .padding(.horizontal, 30)
            Text("Favorite Color: \(familyMember.favoriteColor)")
                .font(.custom("HiraginoSans-W8", size: 20))
                .padding(.horizontal, 30)
            Spacer()
        }
        .background {
            Color(.systemGray5)
                .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity)
        .overlay {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 35))
                            .padding(20)
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var familyMember = FamilyMember(name: "Miles", picture: "Miles", age: 17, birthday: "01/04/2009", favoriteColor: "Purple")
    FamilyMemberDetailView(familyMember: $familyMember)
}
