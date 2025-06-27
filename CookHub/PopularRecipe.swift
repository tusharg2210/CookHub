//
//  PopularRecipe.swift
//  CookHub
//
//  Created by Tushar Gupta on 10/07/24.
//

import SwiftUI

struct PopularRecipe: View {
    
    @AppStorage("userName") var currrentuserName : String?
    @AppStorage("usersignedin") var signedIn  : Bool = false
    @AppStorage("onboardingstate") var OnboardingState : Int?
    @AppStorage("likerecipe") var favRecipe : String?
    
  
    
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        
        LazyVGrid(columns: [GridItem(.fixed(50))], alignment: .center, spacing: 10, content: {
            
            ForEach(viewModel.randomRecipe) { recipe in
                
                ZStack{
                    if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .opacity(0.2)
                                .frame(height: 170)
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .shadow(radius: 5)
                                
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    HStack {
                        
                        ZStack{
                            
                            LinearGradient(colors: [Color.white,Color.white.opacity(0.1)], startPoint: .leading, endPoint: .trailing)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            
                            VStack {
                                Text(recipe.title)
                                    .font(.headline)
                                    .foregroundStyle(Color.black)
                                    .fontDesign(.monospaced)
                                    .bold()
                                    .multilineTextAlignment(.trailing)
                                
                            }
                            .padding()
                            .frame(width: 150,height: 150)
                            
                        }
                        
                        if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: 150, height: 150)
                                    .shadow(radius: 5)

                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                       
                        
                    }
                }
                .overlay(alignment: .bottomLeading, content: {
                    Image(systemName: "heart")
                        .font(.headline)
                        .foregroundStyle(Color.red)
                        .padding()
                })
                .frame(height: 150)
                .frame(width: 350)
                .padding()
                //.background(Color.gray.opacity(0.2))
                
            }
            
            
        })
        .padding()
        .task {
            await viewModel.fetchRecipeRandom()
        }
    }
}

#Preview {
    PopularRecipe()
}
