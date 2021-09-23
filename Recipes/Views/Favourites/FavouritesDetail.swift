//
//  FavouritesDetail.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 18/07/21.
//

import SwiftUI

struct FavouritesDetail: View {
    var id: Int
    var name: String
    var image: String
    
    @State var showModal = false
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageView(withURL: image)
                    .aspectRatio(contentMode: .fill)
                
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
                        .padding(.horizontal)
                }
                )
                .sheet(isPresented: $showModal, content: {
                    IngredientsView(id: id, showModal: $showModal)
                })
                
                ForEach(networkManager.instructions) { item in
                    Text(item.step)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding()
                }
                .overlay(networkManager.isLoading ? ProgressView("LOADING") : nil)
            }
            .navigationBarTitle(name, displayMode: .inline)
            .onAppear {
                networkManager.fetchInstruction(id: id)
        }
        }

    }
}

struct FavouritesDetail_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesDetail(id: 0, name: "", image: "")
    }
}
