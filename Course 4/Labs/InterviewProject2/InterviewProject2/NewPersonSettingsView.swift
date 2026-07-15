//
//  NewPersonSettingsView.swift
//  InterviewProject2
//
//  Created by Miles Norris on 7/14/26.
//

import SwiftUI

struct NewPersonSettingsView: View {
    let apiService: DataFetcher
    
    @State var personCount = 1
    @State var selectedGender: GenderOptions = .both
    @State var genderOptions: [GenderOptions] = [.both, .male, .female]
    
    @State var result: [Person] = []
    @State var generationSuccess = false
    
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("How Many People Should Be Generated?")
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top, 75)
                
                Stepper("\(personCount)", value: $personCount)
                    .bold()
                    .font(.largeTitle)
                    .padding(.horizontal, 120)
                    .padding(.vertical)
                
                Text("Pick The Gender(s)")
                    .bold()
                    .font(.title)
                    .padding(.top, 75)
                
                Picker("Pick The Gender", selection: $selectedGender) {
                    ForEach(genderOptions, id: \.self) { gender in
                        Text(gender.rawValue.dropLast(gender.rawValue.count - 1).uppercased() + gender.rawValue.dropFirst())
                    }
                }
                .pickerStyle(.segmented)
                .padding(30)
                
                Spacer()
                
                Button {
                    Task {
                        do {
                            try await fetchRandomPeople()
                            generationSuccess = true
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Text("Generate")
                        .font(.title2)
                        .bold()
                        .padding(10)
                }
                .buttonStyle(.glassProminent)
                .padding(.bottom, 75)
            }
            .navigationTitle("Random People")
            .navigationDestination(isPresented: $generationSuccess) {
                RandomPeopleView(people: result)
            }
        }
    }
    
    func fetchRandomPeople() async throws {
        let randomPeople = try await apiService.fetchData(RandomPersonAPIRequest(resultCount: personCount, gender: selectedGender))
        
        result = randomPeople.results
    }
}

#Preview {
    NewPersonSettingsView(apiService: DataFetcher())
}
