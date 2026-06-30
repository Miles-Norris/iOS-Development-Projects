//
//  NobelWinnerMainView.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/21/26.
//

import SwiftUI

struct NobelWinnerMainView: View {
    let dataFetcher: APIService
    
    @State var prizes: [Prize] = []
    @State var year = ""
    var body: some View {
        VStack {
            Text("Nobel Prize Winners")
                .font(.system(size: 38))
                .bold()
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Year", text: $year)
                    .bold()
                    .frame(width: 250, height: 50)
                    .onSubmit {
                        Task {
                            if let newPrizes = await fetchPrizes() {
                                prizes = newPrizes
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
            
            if !prizes.isEmpty {
                List {
                    SectionView(category: "Physics", prizes: $prizes)
                    SectionView(category: "Chemistry", prizes: $prizes)
                    SectionView(category: "Medicine", prizes: $prizes)
                    SectionView(category: "Peace", prizes: $prizes)
                    SectionView(category: "Literature", prizes: $prizes)
                    SectionView(category: "Economics", prizes: $prizes)
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
    
    func fetchPrizes() async -> [Prize]? {
        if !year.isEmpty {
            do {
                let prizes = try await dataFetcher.fetchData(NobelWinnerAPIRequest(year: year))
                return prizes.prizes
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
    
    struct SectionView: View {
        let category: String
        
        @Binding var prizes: [Prize]
        var body: some View {
            Section {
                ForEach(prizes, id: \.self) { prize in
                    if prize.category == category.lowercased() {
                        ForEach(prize.laureates, id: \.self) { laurete in
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("\(laurete.firstname) \(laurete.surname)")
                                        .bold()
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(laurete.motivation)
                                        .font(.caption)
                                        .bold()
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            } header: {
                Text(category)
                    .bold()
            }
        }
    }
}

#Preview {
    NobelWinnerMainView(dataFetcher: DataFetcher())
}
