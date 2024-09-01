
import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseStorage
import GoogleSignIn


struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var signupStatusMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Sign Up to Change the World's Logistics")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            TextField("Email", text: $email)
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
                createAccount()
            }) {
                Text("Create Account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            
            if !signupStatusMessage.isEmpty {
                Text(signupStatusMessage)
                    .foregroundColor(signupStatusMessage == "Account created successfully!" ? .green : .red)
                    .font(.subheadline)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
            
            Spacer()
            
            socialSignUpButtons
        }
        .padding()
    }
    
    private var socialSignUpButtons: some View {
        VStack(spacing: 10) {
            Button(action: {
                // Handle Google Sign-Up
            }) {
                socialButtonContent(iconName: "globe", text: "Sign up with Google", color: .orange)
            }
            
            Button(action: {
                // Handle Facebook Sign-Up
            }) {
                socialButtonContent(iconName: "f.circle", text: "Sign up with Facebook", color: .blue)
            }
            
            Button(action: {
                // Handle Apple Sign-Up
            }) {
                socialButtonContent(iconName: "applelogo", text: "Sign up with Apple", color: .black)
            }
        }
    }
    
    private func socialButtonContent(iconName: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: iconName)
            Text(text)
                .font(.headline)
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(color)
        .cornerRadius(10)
        .padding(.horizontal, 40)
    }
    
    private func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .invalidEmail:
                    self.signupStatusMessage = "Invalid email format. Please check your email."
                case .weakPassword:
                    self.signupStatusMessage = "Password is too weak. Please use a stronger password."
                case .emailAlreadyInUse:
                    self.signupStatusMessage = "This email is already in use. Please use a different email."
                case .networkError:
                    self.signupStatusMessage = "Network error. Please check your connection."
                default:
                    self.signupStatusMessage = "Sign up failed. Please try again."
                }
            } else {
                self.signupStatusMessage = "Account created successfully!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.presentationMode.wrappedValue.dismiss()  // Automatically go back to LoginView
                }
            }
        }
    }
    
    
    

}
