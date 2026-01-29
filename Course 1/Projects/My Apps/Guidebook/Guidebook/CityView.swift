//
//  ContentView.swift
//  Guidebook
//
//  Created by Miles Norris on 10/15/25.
//

import SwiftUI

struct CityView: View {
    
   @State var cities = [City]()
    var dataService = DataService()
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView (showsIndicators: false){
                VStack {
                   
                    ForEach(cities) { city in
                        
                        NavigationLink {
                            AttractionView(city: city)
                        } label: {
                            CityCard(city: city)
                                .padding(.bottom, 20)
                        }

                        
                    }
                    
                }
                .padding()
        }
        .ignoresSafeArea()
        .onAppear {
                cities = dataService.getData()
        }
       
        }
    }
}

#Preview {
    CityView()
}
