//
//  DogPhotoSubview.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import SwiftUI

struct DogPhotoSubview: View {
    let photoURl: URL
    var body: some View {
        AsyncImage(url: photoURl) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Text("No Image Found")
                    .foregroundStyle(.gray)
            @unknown default:
                fatalError()
            }
        }
    }
}

#Preview {
    DogPhotoSubview(photoURl: URL(string: "https://images.dog.ceo/breeds/ovcharka-caucasian/IMG_20191108_140417.jpg")!)
}
