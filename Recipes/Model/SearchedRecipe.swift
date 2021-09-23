//
//  SearchedRecipe.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 18/06/21.
//

import SwiftUI

// MARK: - SearchedRecipe
struct SearchedRecipe: Codable {
    let offset, number: Int
    let results: [Result]
    let totalResults: Int
}

// MARK: - Result
struct Result: Codable, Identifiable {
    let id: Int
    let image: String
    let imageType, title: String
}
