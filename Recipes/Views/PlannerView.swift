//
//  PlannerView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 28/08/21.

import SwiftUI

struct PlannerView: View {
    @State private var numberOfCalories = 1.0
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
            
            ScrollView {
                //Form {
                VStack(alignment: .leading) {
                    Section(header: Text("Amount of calories")) {
                        Slider(
                            value: $numberOfCalories,
                            in: 0...500,
                            minimumValueLabel: Text("0"),
                            maximumValueLabel: Text("500")
                        ) {
                            //Text("Speed")
                        }
                        Text("The plan will have \(Int(numberOfCalories)) calories")
                    }
                    .padding(4)
                }
                .background(VisualEffectBlur(blurStyle: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding()
                //}
                //.frame(width: .infinity, height: 144)
                
                
                if !networkManager.generatedPlan.isEmpty {
                    
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 400),spacing: 16),
                                 ])
                    {
                        ForEach(networkManager.generatedPlan) { item in
                            NavigationLink(
                                destination: RecipeDetail(recipe: Result(id: item.id, image: "https://spoonacular.com/recipeImages/\(item.id)-556x370.jpg", imageType: item.imageType, title: item.title)),
                                label: {
                                    VStack {
                                        SearchCardView(recipe: Result(id: item.id, image: "https://spoonacular.com/recipeImages/\(item.id)-556x370.jpg", imageType: item.imageType, title: item.title))
                                        //.frame(height: 300)
                                            .cornerRadius(20)
                                            .padding()
                                    }
                                })
                        }
                        .overlay(networkManager.isLoading ? ProgressView("LOADING") : nil)
                    }
                }
            }
            .navigationTitle("Planner")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        networkManager.generatePlan(targetCalories: Int(numberOfCalories))
                    }, label: {
                        Text("Generate")
                    })
                }
            })
        
    }
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
    }
}
