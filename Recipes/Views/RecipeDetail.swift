//
//  RecipeDetail.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 10/07/21.
//

import SwiftUI

struct RecipeDetail: View {
    var recipe: Result?
    @State var showModal = false
    @State var isFavourite = false
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var favouritesViewModel = FavouritesViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageView(withURL: recipe!.image)
                    .aspectRatio(contentMode: .fill)
                
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
                        IngredientsView(id: recipe!.id, showModal: $showModal)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        isFavourite.toggle()
                        favouritesViewModel.submitFavourites(id: recipe!.id, name: recipe!.title,
                            image: recipe!.image)
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

                
                ForEach(networkManager.instructions) { item in
                    Text(item.step)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding()
                }
                .overlay(networkManager.isLoading ? ProgressView("LOADING") : nil)
            }
            .navigationBarTitle(recipe!.title, displayMode: .inline)
            .onAppear {
                networkManager.fetchInstruction(id: recipe!.id)
        }
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail()
    }
}
