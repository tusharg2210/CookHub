//
//  CookHubApp.swift
//  CookHub
//
//  Created by Tushar Gupta on 04/07/24.
//

import SwiftUI

@main
struct CookHubApp: App {
    
    @AppStorage("userName") var currrentuserName : String?
    @AppStorage("usersignedin") var signedIn  : Bool = false
    
   
    
    let gradiant : RadialGradient = RadialGradient(colors: [Color.mint,Color.main],
                                                   center: .top,
                                                   startRadius: 100,
                                                   endRadius: 800)
    
    let transition : AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some Scene {
        WindowGroup {
            
            if signedIn{
                ContentView()
                    .transition(transition)
                
                
                
            }
            else{
                Onboarding()
            }
            
        }
    }
}
