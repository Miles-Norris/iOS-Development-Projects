//
//  NewCardView.swift
//  BirthdayCards
//
//  Created by Miles Norris on 5/18/26.
//

import SwiftUI
import PhotosUI

struct NewCardView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var cards: [BirthdayCard]
    
    @State var description: String = ""
    @State var selectedDate: Date = Date()
    @State var selectedColor: Color = .blue
    @State var selectedThemePhoto: PhotosPickerItem?
    @State var photoToDisplay: UIImage? = nil
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Party Description", text: $description)
                    
                    ColorPicker("Theme Color", selection: $selectedColor, supportsOpacity: false)
                    
                    DatePicker("Date", selection: $selectedDate)
                    
                    PhotosPicker("Theme Photo", selection: $selectedThemePhoto, matching: .images)
                    
                    if let photoToDisplay {
                        Image(uiImage: photoToDisplay)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 335, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                
                Button("Save") {
                    cards.append(BirthdayCard(backgroundColor: selectedColor, selectedDate: selectedDate, themePhoto: photoToDisplay, partyDescription: description))
                    
                    dismiss()
                }
                .font(.title2)
                .bold()
                .buttonStyle(.borderedProminent)
                .disabled(description == "")
            }
            .background {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
            }
            .onChange(of: selectedThemePhoto) { oldValue, newValue in
                if newValue != oldValue {
                    processPhotoData(newValue)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "multiply") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func processPhotoData(_ photo: PhotosPickerItem?) {
        Task {
            if let photo {
                if let data = try? await photo.loadTransferable(type: Data.self) {
                    photoToDisplay = UIImage(data: data)
                }
            } else {
                photoToDisplay = nil
            }
        }
    }
}

