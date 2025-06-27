//
//  SplashScreen.swift
//  CookHub
//
//  Created by Tushar Gupta on 04/07/24.
//

import SwiftUI

struct Onboarding: View {
    
    
    @AppStorage("userName") var currrentuserName : String?
    @AppStorage("usersignedin") var signedIn  : Bool = false
    
    
    @State var OnboardingState : Int = 0
    @State var userName : String = ""
    @State private var scale: CGFloat = 0.2
    @State private var isSignup = false
    @State private var isActive = false
    
    @State private var position : CGFloat = 0
    
    let gradiant : RadialGradient = RadialGradient(colors: [Color.main,Color.black],
                                                   center: .top,
                                                   startRadius: 100,
                                                   endRadius: 1100)
    
    let transition : AnyTransition = .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top))
    
    var body: some View {
        
        ZStack {
            gradiant
                .ignoresSafeArea()
            
            ZStack{
                
                
                switch OnboardingState{
                    
                case 0:
                    signUp
                    
                case 1:
                    adddName
                        .transition(transition)
                    
                default :
                    signUp
                    
                }
                
            }
            
        }
        
    }
}

#Preview {
    Onboarding()
}


//MARK: Components
extension Onboarding{
    
    private var splashScreen : some View{
        VStack(spacing : 5) {
            Image("Icon3")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.easeOut(duration: 2.3)) {
                        self.scale = 5
                    }
                    withAnimation(.easeIn(duration: 2.4)) {
                        self.scale = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                        withAnimation(.easeOut) {
                            isSignup = true
                            position = 120
                        }
                    }
                }
        }
        
    }
    
    private var signUp : some View{
        VStack(spacing : 8){
            Spacer()
            
              VStack{
                  
                  splashScreen
               
                
                if isSignup{
                    VStack(spacing : 2){
                        Text("CookHub")
                            .font(.largeTitle)
                            .fontDesign(.serif)
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding(10)
                            .overlay {
                                Capsule(style: .circular)
                                    .frame(height: 2)
                                    .frame(width: 170)
                                    .foregroundStyle(Color.white)
                                    .offset( y: 22)
                            }
                        
                        Text("'' Discover the Logic Behind Every Bite ''")
                            .font(.subheadline)
                            .bold()
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.white)
                        
                        Spacer()
                    }
                    .transition(transition)
                }
                
              }
              .offset(y: position)
         
            Spacer()
            
            
            if isSignup{
                    Text("Sign up" )
                        .font(.title2)
                        .bold()
                        .fontDesign(.serif)
                        .foregroundStyle(Color.main)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .transition(transition)
                        .padding(.horizontal,40)
                        .onTapGesture {
                            withAnimation(.spring) {
                                OnboardingState = 1
                            }
                            
                        }
                    
                
                
            }
            
            
        }
        
    }
    
    
    private var adddName : some View{
        VStack(alignment : .center,spacing : 20){
            Spacer()
            
            Text("What's your Name?")
                .font(.largeTitle)
                .bold()
                .fontDesign(.rounded)
                .foregroundStyle(Color.white)
            
            TextField("Enter name here...", text: $userName)
                .foregroundStyle(Color.main)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(.horizontal,30)
            
            
            Spacer()
            Spacer()
            if userName.count >= 3{
                Text("Finish" )
                    .font(.title2)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundStyle(Color.main)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .transition(transition)
                    .padding(.horizontal,40)
                    .onTapGesture {
                        withAnimation {
                            currrentuserName = userName
                            signedIn = true
                        }
                        
                    }
            }
            
        }
    }
    
}


//MARK: FUNCTIONS
extension Onboarding{
    
}
