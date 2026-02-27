//
//  EditRecipeScreen.swift
//  Recipe Tracker (Navigation Lab)
//
//  Created by Miles Norris on 2/25/26.
//

import SwiftUI

struct EditRecipeScreen: View {
    @Binding var recipe: Recipe
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Recipe Title", text: $recipe.title)
                    .font(.largeTitle)
                    .bold()
                
                Text("**Ingredients**")
                    .font(.headline)
                TextEditor(text: $recipe.ingredients)
                
                Text("**Instructions**")
                    .font(.headline)
                TextEditor(text: $recipe.instructions)
                
                Spacer()
            }
            .padding()
        }
    }
}

