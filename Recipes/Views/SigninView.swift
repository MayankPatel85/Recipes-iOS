//
//  SigninView.swift
//  Recipes
//
//  Created by MΔΨΔΠҜ PΔTΣL on 16/06/21.
//

import SwiftUI
import FirebaseAuth

struct SigninView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State var isNew = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showSignIn = false
    
    var body: some View {
        VStack {
            Text("Welcome, Chef")
                .font(.title)
                .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
            
            Spacer()
            
            Image("Chef")
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer()
            
            VStack {
                
                if isNew {
                    HStack(spacing: 8.0) {
                        Image(systemName: "person.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                            .frame(width: 40, height: 40)
                        TextField("Enter username", text: $username)
                            .textContentType(.username)
                    }
                    .padding()
                }
                
                HStack(spacing: 8.0) {
                    Image(systemName: "envelope.open.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                        .frame(width: 40, height: 40)
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                }
                .padding()
                //.frame(width: .infinity, height: 52.0)
                
                HStack(spacing: 8.0) {
                    Image(systemName: "key.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                        .frame(width: 40, height: 40)
                    SecureField("Enter password", text: $password)
                        .textContentType(.password)
                }
                .padding()
                //.frame(width: .infinity, height: 52.0)
            }
            .background(VisualEffectBlur(blurStyle: .systemThickMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding()
            .animation(.easeInOut)
            
            Spacer()
            
            Button(action: {
                signIn()
            }, label: {
                Text(isNew ? "Sign Up" : "Sign In")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(VisualEffectBlur(blurStyle: .systemMaterial))
                    .cornerRadius(20)
                    .padding()
            })
            
            HStack {
                Text(isNew ? "Already have account" : "Don't have an account")
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button(action: {
                    self.isNew.toggle()
                },
                label: {
                    Text(isNew ? "Log in" : "Create account")
                })
            }
            .padding(.horizontal)
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
        })
        .onAppear {
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if let currentUser = user {
                    print(currentUser.displayName ?? " ")
                    showSignIn.toggle()
                }
            }
        }
        .fullScreenCover(isPresented: $showSignIn, content: {
            TabBarView()
        })
    }
    
    func signIn() {
        if isNew {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    alertTitle = "Something Went Wrong!"
                    alertMessage = error!.localizedDescription
                    print(error!.localizedDescription)
                    showAlert.toggle()
                }
                else {
                    alertTitle = "WooHoo"
                    alertMessage = "Successful"
                    showAlert.toggle()
                }
            }
        }
        else {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    alertTitle = "Something Went Wrong!"
                    alertMessage = error!.localizedDescription
                    showAlert.toggle()
                }
            }
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
