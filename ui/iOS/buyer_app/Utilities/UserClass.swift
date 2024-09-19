//
//  UserClass.swift
//  buyer_app
//
//  Created by Jerry Cheng on 9/6/24.
//

import Foundation
import SwiftUI


struct CurrentUser {
    let uid, email, profileImage: String
}

class MainMessageViewModel: ObservableObject{
    @Published var errorMessage = ""
    @Published var currentUser: CurrentUser?
    @Published var isLoggedIn = false
    
    init(){
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid 
        else{
            self.errorMessage = "Could not find the firebase uid"
            return
        }
        
//        self.errorMessage = "\(uid)"
        
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument{ snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch the current user \(error)"
                    print("Failed to fetch current user", error)
                    return
                }
                
                guard let data = snapshot?.data() 
                else {
                    self.errorMessage = "No data found"
                    return
                }
//                print(data)
                self.errorMessage = "Data: \(data.description)"
                let uid = data["uid"] as? String ?? "" 
                let email = data["email"] as? String ?? ""
                let profileImage = data["profileImage"] as? String ?? ""
                self.currentUser = CurrentUser(uid: uid, email: email, profileImage: profileImage)
                
//               self.errorMessage = currentUser.profileImageUrl
            }
    }
    
    func handleSignout(){
        isLoggedIn.toggle()
    }
}
