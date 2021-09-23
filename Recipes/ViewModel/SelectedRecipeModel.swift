//
//  SelectedRecipeModel.swift
//  Recipes
//
<<<<<<< HEAD
//  Created by MΔΨΔΠҜ PΔTΣL on 01/09/21.
=======
//  Created by MΔΨΔΠҜ PΔTΣL on 02/09/21.
>>>>>>> ea22d3b8b4c222ed43e8b7788bc72e5f36d4b6f9
//

import Foundation

class SelectedRecipeModel: ObservableObject {
    @Published var recipe: Recipes = Recipes(id: 1, title: "", image: "", readyInMinutes: 1)
    @Published var isShowing: Bool = false
}
