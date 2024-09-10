//
//  ChatLogViewModel.swift
//  buyer_app
//
//  Created by Jerry Cheng on 9/10/24.
//

import Foundation
import SwiftUI
import Firebase

class ChatLogViewModel: ObservableObject {
    
    @Published var currentUser: ChatUser? // Use ChatUser
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    init() {
        // Retrieve the current Firebase user
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "No user logged in"
            return
        }
        
        // Fetch user data from Firestore
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch user: \(error.localizedDescription)"
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found for user"
                return
            }
            
            // Initialize ChatUser
            self.currentUser = ChatUser(data: data)
        }
    }
    
    func handleSend() {
        print(chatText)
        
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        
        guard let toId = currentUser?.uid else {
            return
        }

        let document =
            FirebaseManager.shared.firestore
                .collection("messages")
                .document(fromId)
                .collection(toId)
                .document()
        
        let messageData = [
            "fromId": fromId,
            "toId": toId,
            "text": self.chatText,
            "timestamp": Timestamp()
        ] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message to Firestore: \(error.localizedDescription)"
                return
            }
            
            // Optionally save to the other user's messages collection
            FirebaseManager.shared.firestore
                .collection("messages")
                .document(toId)
                .collection(fromId)
                .document()
                .setData(messageData)
        }
        
        // Clear the chat text after sending
        self.chatText = ""
    }
}
