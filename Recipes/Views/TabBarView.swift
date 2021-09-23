//
//  TabBarView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 10/07/21.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var selectedRecipeModel = SelectedRecipeModel()
    @StateObject var networkManager = NetworkManager()
    @Namespace var animation
    
    var body: some View {
        ZStack {
            TabView {
<<<<<<< HEAD
                
                NavigationView {
                    HomeView(namespace: animation, selectedRecipeModel: selectedRecipeModel, networkManager: networkManager)
=======
                NavigationView {
                    ContentView(namespace: animation, selectedRecipeModel: selectedRecipeModel, networkManager: networkManager)
>>>>>>> ea22d3b8b4c222ed43e8b7788bc72e5f36d4b6f9
                        .navigationBarHidden(true)
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                NavigationView {
                    FavouritesView()
                }
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favourites")
                }
                
                PlannerView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Planner")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
            }
            .accentColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
<<<<<<< HEAD
            .opacity(selectedRecipeModel.isShowing ? 0 :1)
=======
            .opacity(selectedRecipeModel.isShowing ? 0 : 1)
>>>>>>> ea22d3b8b4c222ed43e8b7788bc72e5f36d4b6f9
            
            if selectedRecipeModel.isShowing {
                SelectedRecipeDetail(selectedRecipe: selectedRecipeModel, networkManager: networkManager, namespace: animation)
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
