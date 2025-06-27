//
//  API.swift
//  CookHub
//
//  Created by Tushar Gupta on 08/07/24.
//

import Foundation
import SwiftUI

class RecipeViewModel: ObservableObject {
    
    let cuisinetypes : [String] = ["African","Asian","American","British","Cajun","Caribbean","Chinese","Eastern European","European","French","German","Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]
    
    let diettypes : [String] = [ "Gluten Free","Ketogenic","Vegetarian","Lacto-Vegetarian","Ovo-Vegetarian","Vegan","Pescetarian","Paleo","Primal","Low FODMAP","Whole30"]
    
    @Published var cuisineRecipe = [Recipe]()
    
    @Published var randomRecipe = [Recipe]()
    
    @Published var dietRecipe = [Recipe]()
    
    @Published var filterRecipe = [Recipe]()
    
    
    private let apiKey = "735f3893afd04314bbf4df58718975ca"
    
    func fetchRecipesbyCuisine(for cuisine: [String]) async {
           let urlString = "https://api.spoonacular.com/recipes/complexSearch?cuisine=\(cuisine)&apiKey=\(apiKey)"
           guard let url = URL(string: urlString) else {
               print("Invalid URL")
               return
               
           }

           do {
               let (data, _) = try await URLSession.shared.data(from: url)
               let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
               DispatchQueue.main.async {
                   
                   self.cuisineRecipe = recipeResponse.results
                   
               }
           } catch {
               print("Error fetching recipes: \(error)")
           }
       }
    
    func fetchRecipeRandom() async{
        
        let urlstring = "https://api.spoonacular.com/recipes/complexSearch?&apiKey=\(apiKey)"
        guard let url = URL(string: urlstring) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from : url)
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            DispatchQueue.main.async{
                self.randomRecipe = recipeResponse.results
            }
            
        }
        catch{
            print("Error fetching recipes: \(error)")
        }
        
        
    }
    
    func fetchrecipebyDiet(for diet : [String]) async{
        
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?diet=\(diet)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
            
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            DispatchQueue.main.async {
                
                self.dietRecipe = recipeResponse.results
                
            }
        } catch {
            print("Error fetching recipes: \(error)")
        }
        
    }
    
    func fetchrecipebyfilter(for diet : [String], for cuisine : [String]) async{
        
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?/cuisine=\(cuisine)diet=\(diet)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
            
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            DispatchQueue.main.async {
                
                self.filterRecipe = recipeResponse.results
                
            }
        } catch {
            print("Error fetching recipes: \(error)")
        }
        
    }
    
    
    

       func fetchAllRecipes() async {
           await fetchRecipesbyCuisine(for: [cuisinetypes.description] )
           await fetchrecipebyDiet(for: [diettypes.description])
           await fetchrecipebyfilter(for: [diettypes.description], for: [cuisinetypes.description])
           await fetchRecipeRandom()
       }
    
    
}


//enum ErrorCases : Error{
//    case invalidURL
//    case invalidData
//    case invalidResponse
//    
//
//    
//}
