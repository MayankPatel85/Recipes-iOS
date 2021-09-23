//
//  IngredientsView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 17/06/21.
//

import SwiftUI

struct IngredientsView: View {
    var id: Int = 1003464
    @Binding var showModal: Bool
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
//                    if networkManager.isLoading {
//                        ProgressView("loading")
//                            .frame(alignment: .center)
//                    }
                    
                    ForEach(networkManager.ingredients) { item in
                        HStack(spacing: 16.0) {
                            ImageView(withURL: "https://spoonacular.com/cdn/ingredients_100x100/\(item.image)")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 56, height: 56)
                                .background(Color.primary.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                            
                            Text(item.name.capitalized)
                                .font(.body)
                            //.fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("\(String(format: "%.2f", item.amount.us.value)) \(item.amount.us.unit)")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                }
                .overlay(networkManager.isLoading ? ProgressView("LOADING") : nil)
                .navigationBarTitle("Ingredients", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showModal = false
                }, label: {
                    Text("Done")
                }))
                .onAppear {
                    networkManager.fetchIngredients(id: id)
                }
            }
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView(showModal: .constant(false))
    }
}
