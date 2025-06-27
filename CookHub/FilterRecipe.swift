//
//  FilterRecipe.swift
//  CookHub
//
//  Created by Tushar Gupta on 10/07/24.
//

import SwiftUI

struct FilterRecipe: View {
    
    @AppStorage("userName") var currrentuserName : String?
    @AppStorage("usersignedin") var signedIn  : Bool = false
    @AppStorage("onboardingstate") var OnboardingState : Int?
    
  
    @StateObject private var viewModel = RecipeViewModel()
    
    @State var isFilter : Bool = false
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    let cuisinetypes : [String] = ["African","Asian","American","British","Cajun","Caribbean","Chinese","Eastern European","European","French","German","Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]
    
    let diettypes : [String] = [ "Gluten Free","Ketogenic","Vegetarian","Lacto-Vegetarian","Ovo-Vegetarian","Vegan","Pescetarian","Paleo","Primal","Low FODMAP","Whole30"]
    
    @State var selectedCuisine : [String] = [ ]
    @State var selectedDiet : [String] = [ ]
    
    var body: some View {
        ScrollView{
        
            VStack(alignment : .leading){
                
                //Based on Cuisines
                VStack(alignment : .leading){
                    Text("Cuisines")
                        .font(.title2)
                        .fontDesign(.serif)
                        .bold()
                        .padding()
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 12,  content: {
                        
                        ForEach(cuisinetypes, id: \.self) { cuisines in
                            Text(cuisines)
                                .font(.subheadline)
                                .padding()
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    
                                    if selectedCuisine.contains(cuisines){
                                        selectedCuisine.removeAll{ $0 == cuisines }
                                    }
                                    else{
                                        selectedCuisine.append(cuisines)
                                    }
                                    
                                }
                            .frame(width: 100, height: 100)
                                .background(selectedCuisine.contains(cuisines) ? Color.accentColor : Color.gray.opacity(0.9))
                                .foregroundStyle(Color.white)
                            .clipShape(Circle())
                            //.shadow(radius: 5)
                        }
                        
                    })
                    
                        
                }
                .padding()
                Spacer()
                
                //Based on Diet
                VStack(alignment : .leading){
                    Text("Diet")
                        .font(.title2)
                        .fontDesign(.serif)
                        .bold()
                        .padding()
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 12,  content: {
                        
                        ForEach(diettypes, id: \.self) { diet in
                            Text(diet)
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .padding()
                                .onTapGesture {
                                    
                                    if selectedDiet.contains(diet){
                                        selectedDiet.removeAll{ $0 == diet }
                                    }
                                    else{
                                        selectedDiet.append(diet)
                                    }
                                    
                                }
                                .frame(width: 100, height: 100)
                                .background(selectedDiet.contains(diet) ? Color.accentColor : Color.gray.opacity(0.9))
                                .foregroundStyle(Color.white)
                            .clipShape(Circle())
                        }
                        
                    })
                       
                }
                .padding()
                Spacer()
                
            }
            
            
            VStack{
                
                NavigationLink {
                    filterrecipeview(selectedCuisine: $selectedCuisine, selectedDiet: $selectedDiet)
                } label: {
                    Text("Apply")
                        .font(.title3)
                        .bold()
                        .fontDesign(.serif)
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(lineWidth: 3.0)
                        )
                    
                }

                   
            }
            .padding()
            
            
        }
    }
}

#Preview {
    FilterRecipe()
}

struct filterrecipeview  : View {
    @Binding var selectedCuisine :  [String]
    @Binding var selectedDiet : [String]
    
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        
        ScrollView{
            LazyVGrid(columns: [GridItem(.fixed(50))], alignment: .center, spacing: 10, content: {
                
                ForEach(viewModel.filterRecipe) { recipe in
                    
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
            .task {
                await viewModel.fetchrecipebyfilter(for: [selectedDiet.description], for: [selectedCuisine.description])
            }
            
        }
    }
}
