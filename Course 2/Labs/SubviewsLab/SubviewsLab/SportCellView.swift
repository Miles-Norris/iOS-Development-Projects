//
//  SportCellView.swift
//  SubviewsLab
//
//  Created by Miles Norris on 2/27/26.
//

import SwiftUI

struct SportCellView: View {
    @Binding var currentlySelectedSport: String
    @Binding var sportSubmitted: Bool
    
    let sportName: String
    
    var body: some View {
        Button {
            currentlySelectedSport = sportName
            withAnimation {
                sportSubmitted = false
            }
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(currentlySelectedSport == sportName ? Color.limeGreen : Color.darkGreen)
                .frame(width: 120, height: 120)
                .overlay {
                    Text("\(sportName)")
                        .foregroundStyle(Color.white)
                        .font(.title3)
                        .bold()
                }
        }
    }
}

#Preview {
    @Previewable @State var currentlySelecetedSport = "Baseball"
    @Previewable @State var sportSubmitted = false
    SportCellView(currentlySelectedSport: $currentlySelecetedSport, sportSubmitted: $sportSubmitted, sportName: "Baseball")
}
