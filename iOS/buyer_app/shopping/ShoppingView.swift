//
//  ShoppingView.swift
//  buyer_app
//
//  Created by Jerry Cheng on 8/26/24.
//
import SwiftUI

struct ShoppingView: View {
    @ObservedObject var appModeManager: AppModeManager
//    @StateObject var languageSettings = LanguageSettings() // Create the global language settings
    
    var body: some View {
        // bottom navigation bar:
        TabView {
            BrowseView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Browse")
//                .environmentObject(languageSettings) // Pass it to the environment
                }
            
            OrdersView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Orders")
                }
            
            MessagesView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Messages")
                }
            
            // Pass the appModeManager to ProfileView
            ProfileView(appModeManager: appModeManager)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.orange) // Set orange as the dominant color for the tab bar
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView(appModeManager: AppModeManager())
    }
}

