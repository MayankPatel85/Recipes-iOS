//
//  SelectedRecipeDetail.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 05/09/21.
//

import SwiftUI

struct SelectedRecipeDetail: View {
    @ObservedObject var selectedRecipe: SelectedRecipeModel
    @ObservedObject var networkManager: NetworkManager
    @ObservedObject var favouritesViewModel = FavouritesViewModel()
    @State var showModal = false
    @State var isFavourite = false
    
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack {
                ScrollView {
                    CardView(recipe: selectedRecipe.recipe)
                        .matchedGeometryEffect(id: selectedRecipe.recipe.id, in: namespace)
                        .frame(height: 350)
                    
                        VStack(alignment: .leading, spacing: 16.0) {
                            
                            HStack {
                                Button(action: {
                                    showModal.toggle()
                                }, label: {
                                    Text("Watch Ingredients")
                                        .font(.body)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.blue)
                                        .padding()
                                        .background(Color.primary.opacity(0.1))
                                        .clipShape(Capsule())
                                })
                                .sheet(isPresented: $showModal, content: {
                                    IngredientsView(id: selectedRecipe.recipe.id, showModal: $showModal)
                                })
                                
                                Spacer()
                                
                                Button(action: {
                                    isFavourite.toggle()
                                    favouritesViewModel.submitFavourites(id: selectedRecipe.recipe.id, name: selectedRecipe.recipe.title,
                                                                         image: selectedRecipe.recipe.image)
                                }, label: {
                                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                                        .font(.body)
                                        .foregroundColor(.blue)
                                        .padding()
                                        .background(Color.primary.opacity(0.1))
                                        .clipShape(Circle())
                                })
                            }
                            .padding(.horizontal)
                            
//                            if(networkManager.isLoading) {
//                                VStack {
//                                    ProgressView("loading")
//                                }
//                                .frame(maxWidth: .infinity, alignment: Alignment.center)
//                            }
                            
                            ForEach(networkManager.instructions) { item in
                                Text(item.step)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                            }
                            .overlay(networkManager.isLoading ? ProgressView("LOADING") : nil)
                        }
                        .padding()
                    
                }
                
            }
            //.transition(.scale(scale: 0.01, anchor: .center))
            //.matchedGeometryEffect(id: "Container\(selectedRecipe.recipe.id)", in: namespace)
            .background(Color("Background"))
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                networkManager.fetchInstruction(id: selectedRecipe.recipe.id)
            })
            
            CloseButton()
                .padding(.trailing)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedRecipe.isShowing.toggle()
                    }
                }
        }
    }
}
