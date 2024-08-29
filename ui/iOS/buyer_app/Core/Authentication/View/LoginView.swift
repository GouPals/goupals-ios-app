////
////  LoginView.swift
////  buyer_app
////
////  Created by Jerry Cheng on 8/25/24.
////
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseCore

//class FirebaseManager: NSObject {
//    let auth: Auth
//    
//    static let shared = FirebaseManager()
//    
//    override init(){
//        FirebaseApp.configure()
//        
//        self.auth = Auth.auth()
//        
//        super.init()
//    }
//}


struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State var email = ""
    @State var password = ""
    @State private var showSignUp = false
    
    var body: some View {
        VStack {
            Text("Welcome to GouPals")
                .font(.largeTitle)
                .padding(.bottom, 40)

            TextField("Username", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .padding(.horizontal, 40)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .padding(.horizontal, 40)

            Button(action: {
                // Handle login logic here
                loginAccount()
                
                // change the log in global variable to true
                
                
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
            
            Text(self.loginStatusMessage)
                .foregroundColor(.red)
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func loginAccount(){
        print("You have successfully logged in! ")
        Auth.auth().signIn(withEmail: email, password: password){
            result, err in
            if let err = err {
                print("Failed to create a user ", err)
                self.loginStatusMessage = "Failed to log in to the account \(err)"
                return
            }
            
            print("Successfully created the user! \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully logged in to user! \(result?.user.uid ?? "")"
            isLoggedIn = true
        }
        
        
    }
}
