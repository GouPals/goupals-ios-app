import SwiftUI
import Firebase

struct ContentView: View {
    @State private var isLoggedIn = false
    @ObservedObject var appModeManager = AppModeManager()
    
    init(){
        FirebaseApp.configure()
    }


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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

