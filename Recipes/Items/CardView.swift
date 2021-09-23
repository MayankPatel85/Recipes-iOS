//
//  CardView.swift
//  Recipes
//
<<<<<<< HEAD
//  Created by MΔΨΔΠҜ PΔTΣL on 29/08/21.
=======
//  Created by MΔΨΔΠҜ PΔTΣL on 02/09/21.
>>>>>>> ea22d3b8b4c222ed43e8b7788bc72e5f36d4b6f9
//

import SwiftUI

struct CardView: View {
    var recipe: Recipes
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ImageView(withURL: recipe.image)
                .aspectRatio(contentMode: .fill)
            HStack {
                VStack(alignment: .leading) {
                    Text(recipe.title)
                        .font(.body)
                    Text("\(recipe.readyInMinutes) min")
                        .font(.caption)
                }
                .foregroundColor(.white)
                Spacer()
            }
            .padding()
<<<<<<< HEAD
            .background(
                VisualEffectBlur(blurStyle: .systemMaterialDark)
=======
            .background(VisualEffectBlur(blurStyle: .systemMaterialDark)
>>>>>>> ea22d3b8b4c222ed43e8b7788bc72e5f36d4b6f9
            )
        }
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}
<<<<<<< HEAD
=======

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(recipe: Recipes(id: 1, title: "Pasta", image: "", readyInMinutes: 45))
    }
}
>>>>>>> ea22d3b8b4c222ed43e8b7788bc72e5f36d4b6f9
