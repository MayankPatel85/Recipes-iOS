//
//  FavouritesViewModel.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 18/07/21.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class FavouritesViewModel: ObservableObject {
    @Published var favourites = [Favourites]()
    
    private var db = Firestore.firestore()
    
    func submitFavourites(id: Int, name: String, image: String) {
        db.collection("favourites")
            .document(Auth.auth().currentUser!.uid)
            .collection("userFavourites")
            .document(String(id))
            .setData([
                "id": id,
                "name": name,
                "image": image,
            ])
            { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchFavuorites() {
        db.collection("favourites")
            .document(Auth.auth().currentUser!.uid)
            .collection("userFavourites")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching firstore data")
                    return
                }
                self.favourites = documents.map({ (queryDocumentSnapshot) -> Favourites in
                    let data = queryDocumentSnapshot.data()
                    let id = data["id"] as? Int
                    let image = data["image"] as? String ?? ""
                    let name = data["name"] as? String
                    return Favourites(id: id!, name: name!, image: image)
                })
            }
    }
    
    func delete(id: Int) {
        db.collection("favourites")
            .document(Auth.auth().currentUser!.uid)
            .collection("userFavourites")
            .document(String(id))
            .delete { (error) in
                print("error deleting document")
            }
    }
}
