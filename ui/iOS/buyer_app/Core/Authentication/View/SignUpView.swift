import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
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
}
