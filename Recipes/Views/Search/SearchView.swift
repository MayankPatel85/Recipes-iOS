//
//  SearchView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 18/06/21.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    
    @State var searchString = ""
    
    // Search action. Called when search key pressed on keyboard
    func search() {
        networkManager.searchRecipe(query: searchString)
    }
    
    // Cancel action. Called when cancel button of search bar pressed
    func cancel() {
    }
    
    // View body
    var body: some View {
        // Search Navigation. Can be used like a normal SwiftUI NavigationView.
        SearchNavigation(text: $searchString, search: search, cancel: cancel) {
            // Example SwiftUI View
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 400),spacing: 16),
                    ])
                {
                    ForEach(networkManager.searchedRecipe) { item in
                        NavigationLink(
                            destination: RecipeDetail(recipe: item),
                            label: {
                                VStack {
                                    SearchCardView(recipe: item)
                                        //.frame(height: 300)
                                        .cornerRadius(20)
                                        .padding()
                                }
                            })
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Search")
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
