import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseStorage
import GoogleSignIn
import UserNotifications

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var signupStatusMessage = ""
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                
                Text("Sign Up to Change the World's Logistics")
                    .font(.title)
                    .padding(.bottom, 40)
                
                Button{
                    shouldShowImagePicker.toggle()
                } label: {
                    
                    VStack{
                        if let image = self.image {
                            // if the image is selected using the picker:
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 128, height: 128)
                                .scaledToFit()
                                .cornerRadius(64)
                                
                        }
                        else{
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .foregroundColor(.black)
                                .padding()
                                
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius: 64)
                        .stroke(Color.black, lineWidth: 3))
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
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(selectedImage: $image, sourceType: .photoLibrary)
        }
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
                self.persistImageToStorage()

                // Send a welcome notification after account creation
                sendWelcomeNotification()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func persistImageToStorage(){
        let filename = UUID().uuidString
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
        else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5)
        else{ return }
        
        ref.putData(imageData, metadata: nil){
            metadata, err in
            if let err = err {
                self.signupStatusMessage = "Failed to push the image to storage \(err)"
                return
            }
            ref.downloadURL{ url, err in
                if let err = err {
                    self.signupStatusMessage = "Failed to retrive the downloaded URL: \(err)"
                    return
                }
                self.signupStatusMessage = "Successfully stored the image with the url: \(url?.absoluteString ?? "")"
                
                guard let url = url else{ return
                }
                self.storeUserInformation(imageProfileUrl: url)
                
            }
        }
    }
    
    private func storeUserInformation(imageProfileUrl: URL){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{
            return
        }
        let userData = ["email": self.email,
                        "uid": uid,
                        "profileImage": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData){ err in
                if let err = err {
                    self.signupStatusMessage = "\(err)"
                    return
                }
                
                print("Success! ")
            }
    }
    
}
