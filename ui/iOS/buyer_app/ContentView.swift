import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseMessaging



struct ContentView: View {
    @State var isLoggedIn = true
    @ObservedObject var appModeManager = AppModeManager()
//    @ObservedObject var vm = MainMessageViewModel()

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


