//
//  ContentView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 23/05/21.
//

import SwiftUI

struct ContentView: View {
    var namespace: Namespace.ID
    @State var selectedItem: Recipes? = nil
    @State var showModal = false
    @State var isFavourite = false
    @State var profileSheet = false
    @ObservedObject var selectedRecipeModel: SelectedRecipeModel
    @ObservedObject var networkManager: NetworkManager
    @ObservedObject var favouritesViewModel = FavouritesViewModel()
    
    var body: some View {
        
        recipeCards
            .onAppear {
                self.networkManager.fetchData()
            }
        
    }
    
    private var recipeCards: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            
            VStack {
                ScrollView {
                    
                    HStack {
                        Text("Recipes")
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        
                        Button(action: {
                            profileSheet.toggle()
                        }, label: {
                            Image(systemName: "person.circle")
                                .font(.largeTitle)
                        })
                    }
                    .sheet(isPresented: $profileSheet, content: {
                        ProfileView()
                    })
                    .padding()
                    .padding(.top)
                    
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 400),spacing: 16),
                        ]) {
                        ForEach(networkManager.recipes) { item in
                            VStack {
                                CardView(recipe: item)
                                    .matchedGeometryEffect(id: item.id, in: namespace, isSource: !selectedRecipeModel.isShowing)
                                    .frame(height: 300)
                                    .cornerRadius(20)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                                            //show.toggle()
                                            selectedRecipeModel.isShowing.toggle()
                                            selectedRecipeModel.recipe = item
                                        }
                                    }
                            }
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                }
            }
            .transition(.scale(scale: 0.01, anchor: .center))
        }
        
    }
}

struct SelectedRecipeDetail: View {
    @ObservedObject var selectedRecipe: SelectedRecipeModel
    @ObservedObject var networkManager: NetworkManager
    @ObservedObject var favouritesViewModel = FavouritesViewModel()
    @State var showModal = false
    @State var isFavourite = false
    
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Color("Background")
                .ignoresSafeArea(.all)
            
            VStack {
                ScrollView {
                    CardView(recipe: selectedRecipe.recipe)
                        .matchedGeometryEffect(id: selectedRecipe.recipe.id, in: namespace)
                        .frame(height: 350)
                    
                    
                    ZStack {
                        Color("Background")
                            .ignoresSafeArea(.all)
                        
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
                            
                            if(networkManager.isLoading) {
                                VStack {
                                    ProgressView("loading")
                                }
                                .frame(maxWidth: .infinity, alignment: Alignment.center)
                            }
                            
                            ForEach(networkManager.instructions) { item in
                                Text(item.step)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                    }
                    .transition(.scale(scale: 0.01, anchor: .center))
                }
                
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                networkManager.fetchInstruction(id: selectedRecipe.recipe.id)
            })
            
            CloseButton()
                .padding(.trailing)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedRecipe.isShowing.toggle()
                        //selectedItem = nil
                    }
                }
        }
    }
}
