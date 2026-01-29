//
//  GalleryView.swift
//  Restaurant
//
//  Created by Miles Norris on 10/9/25.
//

import SwiftUI

struct GalleryView: View {
    
    @State var photoData = [String]()
    @State var sheetVisible = false
    @State var selectedPhoto = ""
    
    var dataService = DataService()
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("Gallery")
                .font(Font.largeTitle)
                .bold()
            
            GeometryReader { proxy in
                ScrollView (showsIndicators: true) {
                    LazyVGrid(columns: [GridItem(spacing: 10), GridItem(spacing: 10), GridItem(spacing: 10)], spacing: 10) {
                        ForEach(photoData, id: \.self) { p in
                             Image(p)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: (proxy.size.width-20)/3)
                                .clipped()
                                .onTapGesture {
                                    selectedPhoto = p
                                    sheetVisible = true
                                }
                        }
                    }
                }

            }
            
        }
        .padding(.horizontal)
        .onAppear {
            photoData = dataService.getPhotos()
            
        }
        .sheet(isPresented: $sheetVisible) {
            PhotoView(selectedPhoto: $selectedPhoto,
                      sheetVisible: $sheetVisible)
        }
        
    }
}

#Preview {
    GalleryView()
}
