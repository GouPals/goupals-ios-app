//
//  buyer_appApp.swift
//  buyer_app
//
//  Created by Jerry Cheng on 8/20/24.
//


import SwiftUI
import Combine
import FirebaseCore
import Firebase
import FirebaseAuth
import FirebaseStorage

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


class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct buyer_appApp: App {
    @StateObject var languageSettings = LanguageSettings() // Create the global language settings
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }
}
