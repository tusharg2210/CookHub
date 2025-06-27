//
//  AddRecipe.swift
//  CookHub
//
//  Created by Tushar Gupta on 14/07/24.
//

import SwiftUI

let cuisinetypes : [String] = ["African","Asian","American","British","Cajun","Caribbean","Chinese","Eastern European","European","French","German","Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]

let diettypes : [String] = [ "Vegetarian","Gluten Free","Ketogenic","Lacto-Vegetarian","Ovo-Vegetarian","Vegan","Pescetarian","Paleo","Primal","Low FODMAP","Whole30"]

struct AddRecipe: View {
    

    
    @AppStorage("userName") var currrentuserName : String?
    @AppStorage("usersignedin") var signedIn  : Bool = false
    @AppStorage("onboardingstate") var OnboardingState : Int?
    
  
    @StateObject private var viewModel = RecipeViewModel()
    
    @State var userName : String = ""
    @State var search : String = ""
    @State var defaultName : String = "Hey!"
    @State var selectedtab : Int = 0
    @State var ShowAlert : Bool = false
    @State var summarytdiet : String = ""
    @State var selectdiet : String = ""
    @State var selectcuisine : String = ""
    @State var recipeName : String = ""
    
    
    var body: some View {
        VStack{
            
            VStack(alignment :.leading){
                Text("Recipe Name")
                    .font(.headline)
                
                
                TextField("Enter name here...", text: $recipeName)
                    .padding()
                    .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1.0)
                    )
                    
            }
            .padding()
            
            VStack(alignment : .leading){
                Text("Select Cuisine")
                    .font(.headline)
                
                HStack {
                    Spacer()
                    Picker(selection: $selectcuisine) {
                        ForEach(cuisinetypes, id: \.self) { cuisines in
                            Text(cuisines)
                        }
                    } label: {
                        Text("Cuisine \(selectcuisine)")
                }
                    Spacer()
                }

                
            }
            .padding()
            
            VStack(alignment : .leading) {
                Text("Select Diet")
                    .font(.headline)
                
                HStack {
                    Spacer()
                    Picker(selection: $selectdiet) {
                        ForEach(diettypes, id: \.self) { diet in
                            Text(diet)
                        }
                    } label: {
                        Text("Diet \(selectdiet)")
                }
                    Spacer()
                }
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("Summarize Recipe")
                    .font(.headline)
                
                TextEditor(text: $summarytdiet)
                    .padding()
                    .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(lineWidth: 1)
                    )
                
                
            }
            .frame(height: 250)
            .padding()
            
            Spacer()
            
            VStack(alignment : .center) {
                
                Button(action: {
                    recipeName.removeAll()
                    summarytdiet.removeAll()
                    selectcuisine.removeAll()
                    selectdiet.removeAll()
                    
                    ShowAlert.toggle()
                   
                }, label: {
                    Text("Add")
                        .font(.headline)
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(lineWidth: 1.0)
                        )
                        
                })
               
                
            }
            .alert("Saved Sucessfully", isPresented: $ShowAlert) {
                NavigationLink {
                    ContentView()
                } label: {
                    Text("Ok")
                }

            }
            
        }
        
    }
    
    
    
}

#Preview {
    AddRecipe()
}


