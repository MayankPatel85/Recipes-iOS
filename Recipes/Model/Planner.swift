//
//  Planner.swift
//  Recipes
//
<<<<<<< HEAD
//  Created by MΔΨΔΠҜ PΔTΣL on 28/08/21.
=======
//  Created by MΔΨΔΠҜ PΔTΣL on 02/09/21.
>>>>>>> ea22d3b8b4c222ed43e8b7788bc72e5f36d4b6f9
//

import Foundation

// MARK: - Planner
struct Planner: Codable {
    let meals: [Meal]
    let nutrients: Nutrients
}

// MARK: - Meal
struct Meal: Codable, Identifiable {
    let id: Int
    let imageType, title: String
    let readyInMinutes, servings: Int
    let sourceURL: String

    enum CodingKeys: String, CodingKey {
        case id, imageType, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
    }
}

// MARK: - Nutrients
struct Nutrients: Codable {
    let calories, protein, fat, carbohydrates: Double
}
