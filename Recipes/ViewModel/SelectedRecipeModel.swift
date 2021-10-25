//
//  SelectedRecipeModel.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 01/09/21.

import Foundation

class SelectedRecipeModel: ObservableObject {
    @Published var recipe: Recipes = Recipes(id: 1, title: "", image: "", readyInMinutes: 1)
    @Published var isShowing: Bool = false
}
