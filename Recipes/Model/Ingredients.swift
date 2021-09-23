//
//  Ingredients.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 17/06/21.
//

import Foundation

// MARK: - Ingredients
struct Ingredients: Codable {
    let ingredients: [Ingredient]
}

// MARK: - Ingredient
struct Ingredient: Codable, Identifiable {
    var id: String {
        return name
    }
    let amount: Amount
    let image, name: String
}

// MARK: - Amount
struct Amount: Codable {
    let metric, us: Metric
}

// MARK: - Metric
struct Metric: Codable {
    let unit: String
    let value: Double
}
