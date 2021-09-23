//
//  Instruction.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 13/06/21.
//

import Foundation

struct Instruction: Codable {
    let name: String
    let steps: [Step]
}

// MARK: - Step
struct Step: Codable, Identifiable {
    var id: Int {
        return number
    }
    let equipment, ingredients: [Ent]
    let number: Int
    let step: String
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable {
    let id: Int
    let image, name: String
    let temperature: Length?
}

// MARK: - Length
struct Length: Codable {
    let number: Int
    let unit: String
}

//typealias Instruction = [InstructionElement]
