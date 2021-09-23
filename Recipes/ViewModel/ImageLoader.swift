//
//  ImageLoader.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 02/06/21.
//

import SwiftUI
import Combine

struct ImageView: View {
    @ObservedObject var imageLoader : ImageLoader
    //@State var image: UIImage = UIImage()
    
    init(withURL url: String) {
        imageLoader = ImageLoader(urlString: url)
    }
    
    var body: some View {
        if let image = UIImage(data: imageLoader.data) {
            return Image(uiImage: image).resizable()
        } else {
            return Image(systemName: "photo")
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var data = Data()
    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
