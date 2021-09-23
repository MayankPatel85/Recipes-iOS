//
//  FavouritesView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 18/07/21.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var favouritesViewModel = FavouritesViewModel()
    
    var body: some View {
        
        listView
            .onAppear {
                favouritesViewModel.fetchFavuorites()
            }
        
    }
    
    @ViewBuilder
    var listView: some View {
        if(favouritesViewModel.favourites.isEmpty) {
            emptyView
        } else {
            favouritesList
        }
    }
    
    var emptyView: some View {
        VStack {
            Text("No Favourites...")
        }
        .navigationTitle("Favourites")
    }
    
    var favouritesList: some View {
        List {
            ForEach(favouritesViewModel.favourites) { item in
                NavigationLink(
                    destination: FavouritesDetail(id: item.id, name: item.name, image: item.image),
                    label: {
                        Text(item.name)
                    })
            }
            .onDelete(perform: { indexSet in
                favouritesViewModel.delete(id: favouritesViewModel.favourites[indexSet.first!].id)
            })
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Favourites")
    }
    
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
