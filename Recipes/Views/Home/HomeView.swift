//
//  ContentView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 23/05/21.
//

import SwiftUI

struct HomeView: View {
    var namespace: Namespace.ID
    @State var selectedItem: Recipes? = nil
    @State var showModal = false
    @State var isFavourite = false
    //@State var profileSheet = false
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
                            //profileSheet.toggle()
                        }, label: {
                            Image(systemName: "person.circle")
                                .font(.largeTitle)
                        })
                    }
//                    .sheet(isPresented: $profileSheet, content: {
//                        ProfileView()
//                    })
                    .padding()
                    .padding(.top)
                    
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 400),spacing: 16),
                        ]) {
                        ForEach(networkManager.recipes) { item in
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
                    .padding(16)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .overlay(networkManager.isLoading ? ProgressView("LOADING") : nil)
        .navigationBarHidden(true)        
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(selectedRecipeModel: SelectedRecipeModel())
//    }
//}
