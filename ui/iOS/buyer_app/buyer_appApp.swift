import SwiftUI
import FirebaseCore

class AppModeManager: ObservableObject {
    @Published var isTravelerApp: Bool = false
}

class LanguageSettings: ObservableObject {
    @Published var language: String = "English" // Default language
    
    var availableLanguages = ["English", "French", "Chinese", "Japanese", "Spanish", "Korean"]
    
    func setLanguage(_ newLanguage: String) {
        language = newLanguage
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()  // Only configure Firebase here
        return true
    }
}

@main
struct buyer_appApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate  // Attach AppDelegate
    @StateObject var languageSettings = LanguageSettings() // Create the global language settings
    @State private var isLoggedIn = false
//    @ObservedObject var appModeManager = AppModeManager()
//    @ObservedObject var vm: ChatLogViewModel
//    @State var currentUser: CurrentUser
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            if appModeManager.isTravelerApp {
//                TravelingView(appModeManager: appModeManager)
//            } else {
//                ShoppingView(appModeManager: appModeManager)
//            }
            
        }
    }
}
