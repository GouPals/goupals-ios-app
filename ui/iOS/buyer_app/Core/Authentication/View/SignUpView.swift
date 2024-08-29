import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Sign Up to Change the World's Logistics")
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
                // Add the new user to the firebase database:
                createAccount()
                
            }) {
                Text("Create Account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue) // Changed color to orange
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            
            Text(self.signupStatusMessage)
                .foregroundColor(.red)
            
            Spacer()
            
            Button(action: {
                // Handle Google Sign-Up
            }) {
                HStack {
                    Image(systemName: "globe") // Replace with Google logo if available
                    Text("Sign up with Google")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(10)
                .padding(.horizontal, 40)
            }
            .padding(.bottom, 20)
            
            Button(action: {
                // Handle Facebook Sign-Up
            }) {
                HStack {
                    Image(systemName: "f.circle") // Replace with Facebook logo if available
                    Text("Sign up with Facebook")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal, 40)
            }
            .padding(.bottom, 20)
            
            Button(action: {
                // Handle Apple Sign-Up
            }) {
                HStack {
                    Image(systemName: "applelogo") // Replace with Apple logo if available
                    Text("Sign up with Apple")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10)
                .padding(.horizontal, 40)
            }
        }
        .padding()
    }
    
    @State var signupStatusMessage = ""
    
    private func createAccount(){
//        print("New account is created here! ")
        Auth.auth().createUser(withEmail: email, password: password){
            result, err in
            if let err = err {
                print("Failed to create a user ", err)
                self.signupStatusMessage = "Failed to creat a new account \(err)"
                return
            }
            
            print("Successfully created the user! \(result?.user.uid ?? "")")
            self.signupStatusMessage = "Successfully created the user! \(result?.user.uid ?? "")"
        }
        
    }
}
