//
//  HomeView.swift
//  CookHub
//
//  Created by Tushar Gupta on 07/07/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var networkManager = NetworkManager()
    @State private var query = ""
    @State private var selectedRecipeId: Int?
    @State private var selectedCuisine: Cuisine?
    @State private var showCuisineSelection = false
    @State private var error: String?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search recipes", text: $query, onCommit: {
                    fetchRecipes()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                HStack {
                    if let selectedCuisine = selectedCuisine {
                        Text("Selected Cuisine: \(selectedCuisine.title)")
                    } else {
                        Text("No Cuisine Selected")
                    }
                    Button("Select Cuisine") {
                        showCuisineSelection.toggle()
                    }
                    .padding()
                }
                
                List(networkManager.recipes) { recipe in
                    Button(action: {
                        selectedRecipeId = recipe.id
                    }) {
                        VStack(alignment: .leading) {
                            Text(recipe.title)
                                .font(.headline)
                            if let url = recipe.image {
                                AsyncImage(url: URL(string: url)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }
                
                NavigationLink("Analyze Ingredients", destination: IngredientAnalysisView(networkManager: networkManager))
                    .padding()
                
                NavigationLink("Analyze Instructions", destination: InstructionAnalysisView(networkManager: networkManager))
                    .padding()
                
                if let error = error {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Recipes")
//            .sheet(item: $selectedRecipeId) { id in
//                RecipeDetailView(networkManager: networkManager, recipeId: id)
//            }
//            .sheet(isPresented: $showCuisineSelection) {
//                CuisineSelectionView(networkManager: networkManager, selectedCuisine: $selectedCuisine)
//            }
            .task {
                fetchRecipes()
            }
        }
    }
    
    private func fetchRecipes() {
        Task {
            do {
                try await networkManager.fetchRecipes(query: query)
            } catch {
//                error = error.localizedDescription as! any Error
            }
        }
    }
}

#Preview {
    HomeView()
}
