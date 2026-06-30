//
//  DogMainView.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import SwiftUI

struct DogMainView: View {
    let dataFetcher: APIService
    
    @Binding var dogs: [DogWithName]
    @State var currentDog: Dog? = nil
    @State var currentDogName = ""
    var body: some View {
        NavigationStack {
            VStack {
                if let currentDog {
                    
                    DogPhotoSubview(photoURl: URL(string: currentDog.message)!)
                        .frame(width: 350, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    TextField("Name", text: $currentDogName)
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
                        .padding(.vertical, 15)
                    
                    Button {
                       saveButtonPressed()
                    } label: {
                        Text("Save Dog")
                            .font(.system(size: 21))
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(currentDogName.isEmpty)
                    .padding(.bottom, 10)
                }
                if !dogs.isEmpty {
                    List {
                        ForEach($dogs.reversed()) { dog in
                            NavigationLink(destination: DogDetailView(dog: dog)) {
                                DogListSubview(dog: dog)
                                    .frame(height: 75)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
            }
            .task {
                if let newDog = await fetchRandomDog() {
                    currentDog = newDog
                }
            }
            .onDisappear {
                DogDataManager.saveToFile(dogs: dogs)
            }
        }
    }
    
    func fetchRandomDog() async -> Dog? {
        do {
            let randomDog = try await dataFetcher.fetchData(DogAPIRequest())
            return randomDog
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func saveButtonPressed() {
        
        if let currentDog {
            dogs.append(DogWithName(name: currentDogName, apiResult: currentDog))
        }
        
        Task {
            if let newDog = await fetchRandomDog() {
                currentDog = newDog
                currentDogName = ""
            }
        }
        
    }
}

#Preview {
    @Previewable @State var dogs: [DogWithName] = []
    DogMainView(dataFetcher: DataFetcher(), dogs: $dogs)
}
