//
//  ContentView.swift
//  MeetMyFamily
//
//  Created by Miles Norris on 2/26/26.
//

import SwiftUI

struct MainView: View {
    @State var familyMembers = FamilyMember.familyMembers
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            Color(.systemGray5)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(spacing: 0), GridItem(spacing: 0)], spacing: 0) {
                    ForEach($familyMembers) { familyMember in
                        FamilyMemberView(familyMember: familyMember)
                    }
                }
                .padding(.horizontal, 7)
                .padding(.top, 140)
            }`
            Text("Family")
                .font(.custom("HiraginoSans-W8", size: 40))
                .padding(20)
                .background {
                    Capsule()
                        .glassEffect()
                }
                .padding(.top, 60)
                .padding(.leading)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
