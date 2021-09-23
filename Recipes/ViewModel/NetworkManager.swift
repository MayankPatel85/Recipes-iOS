//
//  NetworkManager.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 03/06/21.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var recipes = [Recipes]()
    @Published var instructions = [Step]()
    @Published var ingredients = [Ingredient]()
    @Published var searchedRecipe = [Result]()
    @Published var generatedPlan = [Meal]()
    @Published var isLoading = false
    
    
    func downloadData(url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil , let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
    
    func fetchData() {
        self.isLoading = true
        guard let url = URL(string: "https://api.spoonacular.com/recipes/random?apiKey=\(apiKey)&number=6") else { return }
        downloadData(url: url) { data in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Recipe.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.recipes = result.recipes
                    self?.isLoading = false
                }
            }catch {
                print(error)
            }
        }
    }
    
    func fetchInstruction(id: Int) {
        self.isLoading = true
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions?apiKey=\(apiKey)") else { return }
        downloadData(url: url) { data in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([Instruction].self, from: data)
                DispatchQueue.main.async { [weak self] in
                    result.forEach { (index) in
                        self?.instructions = index.steps
                        self?.isLoading = false
                    }
                }
            }catch {
                print(error)
            }
        }
    }
    
    func fetchIngredients(id: Int) {
        self.isLoading = true
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/ingredientWidget.json?apiKey=\(apiKey)") else { return }
        downloadData(url: url) { data in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Ingredients.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.ingredients = result.ingredients
                    self?.isLoading = false
                }
            }catch {
                print(error)
            }
        }
    }
    
    func searchRecipe(query: String) {
        self.isLoading = true
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&query=\(query)&number=2") else { return }
        downloadData(url: url) { data in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(SearchedRecipe.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.searchedRecipe = result.results
                    self?.isLoading = false
                }
            }catch {
                print(error)
            }
        }
    }
    
    func generatePlan(targetCalories: Int) {
        self.isLoading = true
        guard let url = URL(string: "https://api.spoonacular.com/mealplanner/generate?apiKey=\(apiKey)&timeFrame=day&targetCalories=\(targetCalories)") else { return }
        downloadData(url: url) { data in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Planner.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.generatedPlan = result.meals
                    self?.isLoading = false
                }
            }catch {
                print(error)
            }
        }
    }
    
//    func generatePlan(targetCalories: Int) {
//        self.isLoading = true
//        guard let url = URL(string: "https://api.spoonacular.com/mealplanner/generate?apiKey=\(apiKey)&timeFrame=day&targetCalories=\(targetCalories)") else { return }
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data else { return }
//            //print(data)
//            do {
//                let result = try JSONDecoder().decode(Planner.self, from: data)
//                //print(result)
//                DispatchQueue.main.async {
//                    self.generatedPlan = result.meals
//                    self.isLoading = false
//                }
//            }catch {
//                print(error)
//            }
//        }.resume()
//    }
}
