//
//  ProfileView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 24/07/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    Image(uiImage: #imageLiteral(resourceName: "background-3"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 500)
                        .clipShape(Circle())
                    
                    Text("Hello, World!")
                    
                    VStack {
                        Button(action: {}, label: {
                            Text("Sign Out")
                                .font(.title2)
                        })
                    }
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(Color.primary.opacity(0.05))
                    
                }
                
            }
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
