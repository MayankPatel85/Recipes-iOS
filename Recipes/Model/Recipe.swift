//
//  Recipes.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 24/05/21.
//

import SwiftUI

struct Recipe: Decodable {
    let recipes: [Recipes]
}

struct Recipes: Decodable,Identifiable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
}

//var recipes = [
//    Recipes(id: 11,title: "Paneer",image: "demo",readyInMinutes: 45),
//    Recipes(id: 111,title: "b",image: "background-3",readyInMinutes: 55),
//]
