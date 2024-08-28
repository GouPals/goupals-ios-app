////
////  LoginView.swift
////  buyer_app
////
////  Created by Jerry Cheng on 8/25/24.
////
//


import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var showSignUp = false

    var body: some View {
        VStack {
            Text("Welcome to the App")
                .font(.largeTitle)
                .padding(.bottom, 40)

            TextField("Username", text: .constant(""))
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .padding(.horizontal, 40)

            SecureField("Password", text: .constant(""))
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .padding(.horizontal, 40)

            Button(action: {
                // Handle login logic here
                isLoggedIn = true
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.orange) // Changed color to orange
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            
            // Sign-Up Button
            Button(action: {
                showSignUp = true
            }) {
                Text("Don't have an account? Sign up!")
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .padding(.top, 20)
            }
            .sheet(isPresented: $showSignUp) {
                SignUpView()
            }
        }
    }
}


//import SwiftUI
//
//struct LoginView: View {
//    @State private var email = ""
//        @State private var password = ""
//        @State private var registered = true
//        
//    var body: some View {
//        VStack(spacing: 20) {
//            
//            // Logo
//            Spacer()
//            Image(systemName: "globe")
//                .resizable()
//                .frame(width: 100, height: 100)
//                .padding(.bottom, 50)
//            
//            Text("GouPals")
//                .font(.title)
//                .bold()
//            
//            Spacer()
//            
//            if registered { // if the user has an acccount with us:
//                
//                // Email & Password fields for Sign Up
//                TextField("Email", text: $email)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//                
//                SecureField("Password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//                
//            } else { // if the user does not have an account with us:
//                
//                TextField("Email", text: $email)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//                
//                SecureField("Password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//                
//  
//            }
//            
//            Spacer()
//            
//            Button(action: {
//                registered.toggle()
//            }) {
//                Text(registered ? "Already have an account? Sign in!" : "Don’t have an account? Sign up!")
//                    .font(.headline)
//            }
//            .padding(.bottom, 20)
//        }
//    }
//
//                
//}
//
//#Preview {
//    LoginView()
//}
