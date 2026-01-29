//
//  ContentView.swift
//  Menu App
//
//  Created by Miles Norris on 10/7/25.
//

import SwiftUI

struct MenuView: View {
    
    @State var menuItems:[MenuItem] =  [MenuItem]()
    var dataService = DataService()
    
    var body: some View {
      
        List(menuItems) { item in
        
     
             MenuListRow(item: item)
        
            
        }
        .listStyle(.plain)
        .onAppear {
            // Call for the data
            menuItems = dataService.getData()
        }
        
    }
}

#Preview {
    MenuView()
}
