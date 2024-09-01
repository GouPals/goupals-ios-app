//
//  TravelingView.swift
//  buyer_app
//
//  Created by Jerry Cheng on 8/26/24.
//

import SwiftUI

struct TravelingView: View {
    @ObservedObject var appModeManager: AppModeManager
    
    var body: some View {
        // Navigation bar
        TabView {
            TraderView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Orders")
                }
            
            TripsView()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Trips")
                }
            
            OngoingView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Ongoing")
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
    }
}

//struct TravelingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TravelingView(appModeManager: AppModeManager())
//    }
//}
