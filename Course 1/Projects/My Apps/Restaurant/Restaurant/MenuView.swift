//
//  MenuView.swift
//  Restaurant
//
//  Created by Miles Norris on 10/9/25.
//

import SwiftUI

struct MenuView: View {
    
    @State var menuItems:[MenuItem] =  [MenuItem]()
    var dataService = DataService()
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            Text("Menu")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
            
            List(menuItems) { item in
            
         
                 MenuListRow(item: item)
            
                
            }
            .cornerRadius(12)
            .padding(.horizontal)
            .listStyle(.plain)
            .onAppear {
                // Call for the data
                menuItems = dataService.getData()
        }
    
        }
        
    }
}

#Preview {
    MenuView()
}

