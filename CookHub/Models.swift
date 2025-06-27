//
//  Models.swift
//  CookHub
//
//  Created by Tushar Gupta on 08/07/24.
//

import Foundation

struct RecipeResponse: Codable {
    let results: [Recipe]
    
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String?
}
