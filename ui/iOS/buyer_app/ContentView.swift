import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseMessaging


class FirebaseManager: NSObject{
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()

    override init(){
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
        
    }
}

struct ContentView: View {
    @State private var isLoggedIn = true
    @ObservedObject var appModeManager = AppModeManager()

    var body: some View {
        if isLoggedIn {
            if appModeManager.isTravelerApp {
                TravelingView(appModeManager: appModeManager)
            } else {
                ShoppingView(appModeManager: appModeManager)
            }
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}


