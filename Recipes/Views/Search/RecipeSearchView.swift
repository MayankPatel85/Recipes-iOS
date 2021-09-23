//
//  RecipeDetail.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 05/06/21.
//

import SwiftUI

struct RecipeSearchView: View {
    @State private var text: String = ""
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        VStack {
            ScrollView {
                TextField("recipe name", text: $text, onCommit: {
                    networkManager.searchRecipe(query: text)
                })
                .padding(14)
                .background(Color.primary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal)
                
                if (networkManager.isLoading) {
                    VStack {
                        ProgressView("LOADING")
                    }
                }
                
                if(networkManager.searchedRecipe.isEmpty) {
                    VStack {
                        Text("no search")
                    }
                } else {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 400),spacing: 16),
                        ]) {
                        ForEach(networkManager.searchedRecipe) { item in
                            NavigationLink(
                                destination: RecipeDetail(recipe: item),
                                label: {
                                    VStack {
                                        SearchCardView(recipe: item)
                                            .frame(height: 300)
                                            .cornerRadius(20)
                                            .padding()
                                    }
                                })
                            
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle("Search")
        
    }
}

struct RecipeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView()
    }
}

struct SearchCardView: View {
    var recipe: Result
    //var namespace: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ImageView(withURL: recipe.image)
                //Image("demo")
                //.resizable()
                .aspectRatio(contentMode: .fill)
            HStack {
                VStack(alignment: .leading) {
                    Text(recipe.title)
                        .font(.body)
                }
                .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(VisualEffectBlur(blurStyle: .systemMaterialDark)
            )
        }
        .background(
            VisualEffectBlur(blurStyle: .systemMaterial)
        )
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}
