//
//  RecipeDetailView.swift
//  Recipe Tracker (Navigation Lab)
//
//  Created by Jane Madsen on 10/8/25.
//

import SwiftUI

struct RecipeDetailScreen: View {
    @Binding var recipe: Recipe

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(recipe.title)
                        .font(.largeTitle)
                        .bold()
                    
                    Text("**Ingredients**")
                        .font(.headline)
                    Text(recipe.ingredients)
                    
                    Text("**Instructions**")
                        .font(.headline)
                    Text(recipe.instructions)
                    
                    Spacer()
                }
                .padding()
            }
            .toolbar {
                NavigationLink(destination: EditRecipeScreen(recipe: $recipe)) {
                    Image(systemName: "pencil")
                }
            }
            .navigationTitle(recipe.title)
        }
    }
}
