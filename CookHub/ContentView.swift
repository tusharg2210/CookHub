//
//  ContentView.swift
//  CookHub
//
//  Created by Tushar Gupta on 04/07/24.
//

import SwiftUI


struct ContentView: View {
    
    @AppStorage("userName") var currrentuserName : String?
    @AppStorage("usersignedin") var signedIn  : Bool = false
    @AppStorage("onboardingstate") var OnboardingState : Int?
    
  
    @StateObject private var viewModel = RecipeViewModel()
    
    @State var userName : String = ""
    @State var search : String = ""
    @State var defaultName : String = "Hey!"
    @State var selectedtab : Int = 0
    @State var profileOptions : [String] = ["Manage Account", "Saved Recipes", "Settings"]
    @State var profileOptionImages : [Image] = [Image(systemName: "person.crop.circle"),
                                                Image(systemName: "bookmark.fill"),
                                                Image(systemName: "gear.circle.fill")]
    

    
    let gradiant : RadialGradient = RadialGradient(colors: [Color.mint, Color.main],
                                                   center: .top,
                                                   startRadius: 100,
                                                   endRadius: 800)
    let transition : AnyTransition = .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .leading))
    
    
    var body: some View {
        
        NavigationStack {
            if selectedtab == 0 {
                toolBarItems
                tabbarItems
                    .toolbar(.visible)
            } else {
                tabbarItems
                    .toolbar(.hidden)
            }
            
           
                
        }
        .navigationBarBackButtonHidden(true)
        

    }
}

#Preview {
    ContentView()
}
//MARK: FUNCTIONS
extension ContentView{
    
    
    
}


// MARK: BUTTONS AND COMPONENTS
extension ContentView {
    
    private var toolBarItems: some View {
      VStack {
           
        }
        
        .toolbar {
            ToolbarItem(placement: .navigation) {
                HStack(spacing: 5) {
                    Text("CookHub")
                        .font(.title2)
                }
                .bold()
                .foregroundStyle(Color.primary)
            }
            
            ToolbarItem(placement: .primaryAction) {
                NavigationLink {
                    
                } label: {
                    Image(systemName: "heart")
                        .font(.headline)
                        .foregroundStyle(Color.secondary)
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                
                NavigationLink {
                    FilterRecipe()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.headline)
                        .foregroundStyle(Color.secondary)
                }

                
                
            }
        }
    }
    
    private var tabbarItems: some View {
        TabView(selection: $selectedtab) {
           homePage
                .tabItem {
                    Image(systemName: "frying.pan")
                    Text("Dishes")
                }.tag(0)
            
            AddRecipe()
                .tabItem {
                    Image(systemName: "plus.diamond.fill")
                    Text("Add")
                }.tag(1)
            
            profileView
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }.tag(2)
        }
        
    }
    
    private var profileView: some View {
        VStack {
            VStack(spacing: 25) {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 400)
                    .frame(height: 220)
                    .foregroundStyle(gradiant.secondary)
                    .ignoresSafeArea()
                    .overlay(alignment: .bottom) {
                        VStack(spacing: 5) {
                            Circle()
                                .stroke(lineWidth: 2.0)
                                .frame(width: 110, height: 110)
                                .foregroundStyle(Color.black)
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                            Text(currrentuserName ?? "Hey!")
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color.main)
                        }
                    }
            }
            List {
                ForEach(0..<profileOptions.count, id: \.self) { index in
                    NavigationLink(destination: getProfileOptionView(index: index)) {
                        HStack {
                            profileOptionImages[index]
                                .font(.title)
                            Text(profileOptions[index])
                                .font(.title2)
                        }
                        .padding(10)
                        .foregroundStyle(Color.primary)
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            Text("Logout")
                .font(.title2)
                .bold()
                .foregroundStyle(Color.white)
                .padding()
                .padding(.horizontal, 30)
                .background(Color.secondary.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onTapGesture {
                    currrentuserName?.removeAll()
                    OnboardingState = 0
                    signedIn = false
                }
        }
    }
    
    private var homePage: some View {
        ScrollView{
            
            VStack(alignment : .leading,spacing: 10){
                
                VStack(alignment : .leading,spacing: 1){
                    
                    
                    Text("Polular Cuisines")
                        .font(.title2)
                        .fontDesign(.serif)
                        .bold()
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(lineWidth: 2)
                        }
                    
                    .padding(18)
                    
                    
                    ScrollView(.horizontal) {
                        PopularCuisines()
                    }
                    
                }
                .padding(10)
                .background(Color.secondary.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .padding(10)
                
                
                
                
                
                VStack(alignment : .leading ,spacing : 1){

                    Text("Polular Diets")
                        .font(.title2)
                        .fontDesign(.serif)
                        .bold()
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(lineWidth: 2)
                        }
                        .padding(18)
                    
                    ScrollView(.horizontal) {
                        PopularDiets()
                    }
                    
                    
                }.padding(10)
                    .background(Color.secondary.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .padding(10)
                
                
                VStack(alignment : .leading,spacing: 1){
                    Text("Polular Recipe")
                        .font(.title2)
                        .fontDesign(.serif)
                        .bold()
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(lineWidth: 2)
                        }
                        .padding(18)
                    
                    //Poppular recipe
                    
                    PopularRecipe()
                    
                    
                }
                .padding(10)
                    .background(Color.secondary.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .padding(10)
                
            }
            
            
               
        }
    }
    
   
    
    
    @ViewBuilder
    private func getProfileOptionView(index: Int) -> some View {
        switch index {
        case 0:
            manageAccount
        case 1:
            savedRecipes
        case 2:
            settings
        default:
            EmptyView()
        }
    }
    
    private var savedRecipes: some View {
        VStack {
            Text("Saved Recipes")
                .font(.title)
                .padding()
        }
    }
    
    private var settings: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .padding()
        }
    }
    
    private var manageAccount: some View {
        VStack(alignment : .center, spacing: 25) {
            Text("Change User Name")
                .font(.headline)
            
            TextField("Enter name here...", text: $userName)
                .padding(15)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 15)
                .overlay(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .shadow(color: .gray, radius: 3, x: 3.0, y: 3.0)
                        .padding(.horizontal, 15)
                }
            Spacer()
            
            Button(action: {
                currrentuserName = userName
                userName.removeAll()
                selectedtab = 0
               
                
            }, label: {
                
                Text("Apply Changes")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(Color.white)
                    .padding()
                    .padding(.horizontal, 30)
                    .background(Color.secondary.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                   
                    
            })
           
        }
        .padding()
    }
    
}


