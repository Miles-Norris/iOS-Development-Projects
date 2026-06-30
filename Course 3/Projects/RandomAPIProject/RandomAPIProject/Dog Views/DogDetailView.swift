//
//  DogDetailView.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import SwiftUI

struct DogDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var dog: DogWithName
    var body: some View {
        VStack {
            DogPhotoSubview(photoURl: URL(string: dog.apiResult.message)!)
                .frame(width: 350, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            TextField("Name", text: $dog.name)
                .bold()
                .frame(width: 250, height: 50)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray6))
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, 25)
            
            Button {
               dismiss()
            } label: {
                Text("Save")
                    .font(.system(size: 21))
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            .disabled(dog.name.isEmpty)
        }
    }
}

#Preview {
    @Previewable @State var dog = DogWithName(name: "Stevie", apiResult: Dog(message: "https://images.dog.ceo/breeds/ovcharka-caucasian/IMG_20191108_140417.jpg", status: "success"))
    DogDetailView(dog: $dog)
}
