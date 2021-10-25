//
//  CardView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 29/08/21.

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
            .background(
                VisualEffectBlur(blurStyle: .systemMaterialDark)
                    .background(VisualEffectBlur(blurStyle: .systemMaterialDark))
            )
        }
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(recipe: Recipes(id: 1, title: "Pasta", image: "", readyInMinutes: 45))
    }
}
