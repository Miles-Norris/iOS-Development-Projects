//
//  ContentView.swift
//  Restaurant
//
//  Created by Miles Norris on 10/9/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        TabView{
            
            MenuView()
                .tabItem {
                    VStack{
                        Image(systemName: "menucard")
                        Text("Menu")
                    }
                    
            }
            
            AboutView()
                .tabItem {
                    VStack{
                        Image(systemName: "info.circle")
                        Text("About")
                    }
                     
                }
            
            GalleryView()
                .tabItem {
                    VStack{
                        Image(systemName: "photo")
                        Text("Gallery")
                    }
                    
                }
        }
        
    }
}

#Preview {
    MainView()
}
