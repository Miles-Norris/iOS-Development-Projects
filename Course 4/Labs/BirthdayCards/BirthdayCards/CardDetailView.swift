//
//  CardDetailView.swift
//  BirthdayCards
//
//  Created by Miles Norris on 5/18/26.
//

import SwiftUI

struct CardDetailView: View {
    @Environment(\.displayScale) private var displayScale
    let card: BirthdayCard
    
    @State var imageToShare: Image?
    var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                Text(card.selectedDate.formatted(date: .numeric, time: .omitted))
                    .font(.largeTitle)
                    .bold()
                
                if let image = card.themePhoto {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 315, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Text(card.partyDescription)
                    .font(.title3)
                    .bold()
                
                Spacer()
            }
            .padding(30)
            .padding(.horizontal, 50)
            .background {
                Color(card.backgroundColor)
                    .frame(width: 360, height: 775)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .frame(maxWidth: .infinity)
//            .onAppear {
//                imageToShare = generateImage()
//            }
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    if let image = imageToShare {
//                        ShareLink(
//                            item: image,
//                            preview: SharePreview("Birthday Card", image: image)
//                        )
//                    }
//                }
//            }
    }
    
//    @MainActor
//        func generateImage() -> Image? {
//            let renderer = ImageRenderer(content: body)
//            
//            // Match the device's display scale for crisp graphics
//            renderer.scale = displayScale
//            
//            if let uiImage = renderer.uiImage {
//                return Image(uiImage: uiImage)
//            }
//            return nil
//        }
}

#Preview {
    CardDetailView(card: BirthdayCard(backgroundColor: .blue, selectedDate: Date(), partyDescription: ""))
}

