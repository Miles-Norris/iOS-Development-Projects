//
//  DogListSubview.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import SwiftUI

struct DogListSubview: View {
    @Binding var dog: DogWithName
    var body: some View {
        HStack {
            DogPhotoSubview(photoURl: URL(string: dog.apiResult.message)!)
                .frame(width: 75, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            Text(dog.name)
                .font(.title2)
                .bold()
                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var dog = DogWithName(name: "Stevie", apiResult: Dog(message: "https://images.dog.ceo/breeds/ovcharka-caucasian/IMG_20191108_140417.jpg", status: "success"))
    DogListSubview(dog: $dog)
}
