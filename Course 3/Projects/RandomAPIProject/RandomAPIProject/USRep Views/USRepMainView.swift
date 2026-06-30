//
//  USRepMainView.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/21/26.
//

import SwiftUI

struct USRepMainView: View {
    let dataFetcher: APIService
    
    @State var reps: [USRep] = []
    @State var zip = ""
    var body: some View {
        VStack {
            Text("Representatives")
                .font(.system(size:45))
                .bold()
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Zip Code", text: $zip)
                    .bold()
                    .frame(width: 250, height: 50)
                    .onSubmit {
                        Task {
                            if let newReps = await fetchReps() {
                                reps = newReps
                            }
                        }
                    }
                
            }
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(.systemGray6))
                
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.gray)
            }
            
            if !reps.isEmpty {
                List(reps, id: \.self) { rep in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(rep.name)
                                .font(.title3)
                                .bold()
                            
                            Divider()
                                .padding(.horizontal, 10)
                            
                            Text("\(rep.party), \(rep.state)")
                                .font(.title3)
                                .bold()
                        }
                        
                        Text(rep.link)
                            .bold()
                    }
                }
                .listStyle(.sidebar)
            } else {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        }
    }
    
    func fetchReps() async -> [USRep]? {
        if !zip.isEmpty {
            do {
                let reps = try await dataFetcher.fetchData(USRepAPIRequest(zip: zip))
                return reps.results
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
}

#Preview {
    USRepMainView(dataFetcher: DataFetcher())
}
