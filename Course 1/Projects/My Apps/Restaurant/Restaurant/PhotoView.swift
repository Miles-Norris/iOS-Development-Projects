//
//  PhotoView.swift
//  Restaurant
//
//  Created by Miles Norris on 10/12/25.
//

import SwiftUI

struct PhotoView: View {
    
    @Binding var selectedPhoto: String
    @Binding var sheetVisible: Bool
    
    var body: some View {
        
        ZStack {
            Image(selectedPhoto)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        sheetVisible = false
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(Color(.systemGray))
                            .scaleEffect(2)
                            .opacity(0.5)
                    }
                    .padding(30)
                }
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    PhotoView(selectedPhoto: Binding.constant("gallery1"),
              sheetVisible: Binding.constant(true))
}
