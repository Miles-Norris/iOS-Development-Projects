//
//  MenuListRow.swift
//  Menu App
//
//  Created by Miles Norris on 10/7/25.
//

import SwiftUI

struct MenuListRow: View {
    
    var item: MenuItem
    
    var body: some View {
        HStack {
            
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
                .cornerRadius(10)
            
            Text(item.name)
                .bold()
            
            Spacer()
            
            Text("$" + item.price)
        }
    }
}

#Preview {
    MenuListRow(item: MenuItem(name: "Test", price: "10.00", imageName: "tako-sushi"))
}
