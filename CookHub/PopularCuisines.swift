//
//  PopularCuisines.swift
//  CookHub
//
//  Created by Tushar Gupta on 09/07/24.
//

import SwiftUI

struct PopularCuisines: View {
    
    @AppStorage("userName") var currrentuserName : String?
    @AppStorage("usersignedin") var signedIn  : Bool = false
    @AppStorage("onboardingstate") var OnboardingState : Int?
    @AppStorage("likerecipe") var favRecipe : String?
    
    let cuisinetypes : [String] = ["African","Asian","American","British","Cajun","Caribbean","Chinese","Eastern European","European","French","German","Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]
  
    @State var likeRecipe : [String] = [ ]
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        
        HStack(alignment : .center,spacing: 0){
            ForEach(cuisinetypes, id: \.self) { cuisine in
                NavigationLink {
                    cuisineFood(cuisine: cuisine)
                } label: {
                    Text(cuisine)
                        .font(.headline)
                        .fontDesign(.serif)
                        .bold()
                        .padding(12)
                        .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(lineWidth: 1)
                        )
                        .clipShape(Capsule())
                        .padding()
                }

                
            }
        }
        
        
        
    }
}


#Preview {
    PopularCuisines()
}


struct cuisineFood : View{
    let cuisine : String
    
    @StateObject private var viewModel = RecipeViewModel()
    
    var body : some View{
        
        VStack(alignment : .leading,spacing: 0){
            Text(cuisine)
                .font(.headline)
                .fontDesign(.serif)
                .foregroundStyle(Color.primary)
                .padding()
            
            
            ScrollView(.vertical){
                               
                LazyVGrid(columns: [GridItem(.fixed(50))], alignment: .center, spacing: 10, content: {
                    
                    ForEach(viewModel.cuisineRecipe) { recipe in
                        
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
                                
                                ZStack{
                                    
                                    LinearGradient(colors: [Color.white,Color.white.opacity(0.1)], startPoint: .trailing, endPoint: .leading)
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
                                
                            }
                        }
                        .overlay(alignment: .bottomTrailing, content: {
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
                
                
                           }
                           .task {
                               await viewModel.fetchRecipesbyCuisine(for: ["\(cuisine)"])
                           }
            
            
            
            
            
        }
        
    }
    
}

