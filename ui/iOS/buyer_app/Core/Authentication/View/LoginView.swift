import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State var email = ""
    @State var password = ""
    @State private var showSignUp = false
    @State var loginStatusMessage = ""
    
    var body: some View {
        VStack {
            Text("Welcome to GouPals")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            Button{
                
            }label: {
                Image(systemName: "person.fill")
                    .font(.system(size: 64))
                    .padding()
            }

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
                loginAccount()
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            
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
            
            if !loginStatusMessage.isEmpty {
                Text(loginStatusMessage)
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                    .transition(.slide)
            }
        }
        .offset(x: loginStatusMessage.isEmpty ? 0 : 10)
    }
    
    private func loginAccount() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .invalidEmail:
                    self.loginStatusMessage = "Invalid email format. Please check your email."
                case .wrongPassword:
                    self.loginStatusMessage = "Incorrect password. Please try again."
                case .userNotFound:
                    self.loginStatusMessage = "No account found for this email. Please sign up."
                case .networkError:
                    self.loginStatusMessage = "Network error. Please check your connection."
                default:
                    self.loginStatusMessage = "Login failed. Please try again."
                }
            } else {
                print("Successfully logged in! User ID: \(result?.user.uid ?? "")")
                self.loginStatusMessage = "Login successful!"
                isLoggedIn = true
            }
        }
    }
}
