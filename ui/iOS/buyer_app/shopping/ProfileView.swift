import SwiftUI

struct ProfileView: View {
    @State private var name = "John Doe"
    @State private var rating = "4.5"
    @State private var reviews = "25 Reviews"
    @State private var bio = "Passionate about driving and connecting with people."
    
    @ObservedObject var appModeManager: AppModeManager

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Top Profile Section
                    VStack {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .padding(.leading)
                            
                            VStack(alignment: .leading) {
                                Text(name)
                                    .font(.headline)
                                Text("Rating: \(rating)")
                                    .font(.subheadline)
                                Text(reviews)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                // Open settings
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .font(.title2)
                            }
                            .padding(.trailing)
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                    // HStack Section for Past Orders, Reviews, Bio
                    HStack(spacing: 30) {
                        VStack {
                            Image(systemName: "cart.fill")
                                .font(.title)
                                .foregroundColor(.orange)
                            Text("Past Orders")
                                .font(.caption)
                        }
                        VStack {
                            Image(systemName: "airplane")
                                .font(.title)
                                .foregroundColor(.orange)
                            Text("Past Trips")
                                .font(.caption)
                        }
                        VStack {
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundColor(.orange)
                            Text("Reviews")
                                .font(.caption)
                        }
                        VStack {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title)
                                .foregroundColor(.orange)
                            Text("Bio")
                                .font(.caption)
                        }
                    }
                    .frame(width: 400, height: 50)
                    .padding(.vertical)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                    // Other Profile Options (Work Hub, Documents, etc.)
                    VStack(alignment: .leading) {
                        ProfileOptionButton(icon: "briefcase.fill", title: "Work Hub")
                        ProfileOptionButton(icon: "doc.fill", title: "Documents")
                        ProfileOptionButton(icon: "creditcard.fill", title: "Payment")
                        ProfileOptionButton(icon: "creditcard", title: "Plus Card")
                        ProfileOptionButton(icon: "building.columns.fill", title: "Tax Info")
                        ProfileOptionButton(icon: "person.crop.circle.fill", title: "Edit Account")
                        ProfileOptionButton(icon: "umbrella.fill", title: "Insurance")
                        ProfileOptionButton(icon: "lock.fill", title: "Security and Privacy")
                        ProfileOptionButton(icon: "gearshape.fill", title: "App Settings")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
                .padding(.top)
                .background(Color(UIColor.systemGroupedBackground))
            }
            .navigationTitle("Account")
            
            // Floating Button to switch apps
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Toggle between travel and shopping app modes using appModeManager
                        appModeManager.isTravelerApp.toggle()
                    }) {
                        Text(appModeManager.isTravelerApp ? "Switch to Shopping" : "Switch to Traveling")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding()
                    Spacer()
                }
            }
        }
    }
}

// Reusable button components for profile options
struct ProfileOptionButton: View {
    var icon: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
                .padding(.leading)
            
            Text(title)
                .font(.headline)
                .padding(.leading)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.trailing)
        }
        .padding(.vertical, 10)
        Divider() // Optional: To separate each option with a line
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(appModeManager: AppModeManager())
    }
}


//import SwiftUI
//
//struct ProfileView: View {
//    @State private var name = "John Doe"
//    @State private var rating = "4.5"
//    @State private var reviews = "25 Reviews"
//    @State private var bio = "Passionate about driving and connecting with people."
//    
//    // Use a binding to receive the isTravelerApp state from ContentView
//    @Binding var isTravelerApp: Bool
//
//    var body: some View {
//        ZStack {
//            ScrollView {
//                VStack(spacing: 20) {
//                    // Top Profile Section
//                    VStack {
//                        HStack {
//                            Image(systemName: "person.crop.circle.fill")
//                                .resizable()
//                                .frame(width: 80, height: 80)
//                                .padding(.leading)
//                            
//                            VStack(alignment: .leading) {
//                                Text(name)
//                                    .font(.headline)
//                                Text("Rating: \(rating)")
//                                    .font(.subheadline)
//                                Text(reviews)
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                            }
//                            Spacer()
//                            Button(action: {
//                                // Open settings
//                            }) {
//                                Image(systemName: "gearshape.fill")
//                                    .font(.title2)
//                            }
//                            .padding(.trailing)
//                        }
//                        .padding()
//                    }
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                    
//                    // HStack Section for Past Orders, Reviews, Bio
//                    HStack(spacing: 30) {
//                        VStack {
//                            Image(systemName: "cart.fill")
//                                .font(.title)
//                                .foregroundColor(.orange)
//                            Text("Past Orders")
//                                .font(.caption)
//                        }
//                        VStack {
//                            Image(systemName: "airplane")
//                                .font(.title)
//                                .foregroundColor(.orange)
//                            Text("Past Trips")
//                                .font(.caption)
//                        }
//                        VStack {
//                            Image(systemName: "star.fill")
//                                .font(.title)
//                                .foregroundColor(.orange)
//                            Text("Reviews")
//                                .font(.caption)
//                        }
//                        VStack {
//                            Image(systemName: "pencil.circle.fill")
//                                .font(.title)
//                                .foregroundColor(.orange)
//                            Text("Bio")
//                                .font(.caption)
//                        }
//                    }
//                    .frame(width: 400, height: 50)
//                    .padding(.vertical)
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                    
//                    // Other Profile Options (Work Hub, Documents, etc.)
//                    VStack(alignment: .leading) {
//                        ProfileOptionButton(icon: "briefcase.fill", title: "Work Hub")
//                        ProfileOptionButton(icon: "doc.fill", title: "Documents")
//                        ProfileOptionButton(icon: "creditcard.fill", title: "Payment")
//                        ProfileOptionButton(icon: "creditcard", title: "Plus Card")
//                        ProfileOptionButton(icon: "building.columns.fill", title: "Tax Info")
//                        ProfileOptionButton(icon: "person.crop.circle.fill", title: "Edit Account")
//                        ProfileOptionButton(icon: "umbrella.fill", title: "Insurance")
//                        ProfileOptionButton(icon: "lock.fill", title: "Security and Privacy")
//                        ProfileOptionButton(icon: "gearshape.fill", title: "App Settings")
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                }
//                .padding(.top)
//                .background(Color(UIColor.systemGroupedBackground))
//            }
//            .navigationTitle("Account")
//            
//            // Floating Button to switch apps
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        // Toggle between travel and shopping app modes using binding
//                        isTravelerApp.toggle()
//                    }) {
//                        Text(isTravelerApp ? "Switch to Shopping" : "Switch to Traveling")
//                            .fontWeight(.bold)
//                            .padding()
//                            .background(Color.black)
//                            .foregroundColor(.white)
//                            .cornerRadius(30)
//                    }
//                    .padding()
//                    Spacer()
//                }
//            }
//        }
//    }
//}
//
//// Reusable button components for profile options
//struct ProfileOptionButton: View {
//    var icon: String
//    var title: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.title2)
//                .foregroundColor(.orange)
//                .padding(.leading)
//            
//            Text(title)
//                .font(.headline)
//                .padding(.leading)
//            
//            Spacer()
//            
//            Image(systemName: "chevron.right")
//                .font(.title2)
//                .foregroundColor(.gray)
//                .padding(.trailing)
//        }
//        .padding(.vertical, 10)
//        Divider() // Optional: To separate each option with a line
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(isTravelerApp: .constant(false))
//    }
//}


//import SwiftUI
//
//struct ProfileView: View {
//    @State private var name = "John Doe"
//    @State private var rating = "4.5"
//    @State private var reviews = "25 Reviews"
//    @State private var bio = "Passionate about driving and connecting with people."
//    
//    // Use a binding to receive the isTravelerApp state from ContentView
//    @Binding var isTravelerApp: Bool
//
//    var body: some View {
//        ZStack {
//            ScrollView {
//                VStack(spacing: 20) {
//                    // Top Profile Section
//                    VStack {
//                        HStack {
//                            Image(systemName: "person.crop.circle.fill")
//                                .resizable()
//                                .frame(width: 80, height: 80)
//                                .padding(.leading)
//                            
//                            VStack(alignment: .leading) {
//                                Text(name)
//                                    .font(.headline)
//                                Text("Rating: \(rating)")
//                                    .font(.subheadline)
//                                Text(reviews)
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                            }
//                            Spacer()
//                            Button(action: {
//                                // Open settings
//                            }) {
//                                Image(systemName: "gearshape.fill")
//                                    .font(.title2)
//                            }
//                            .padding(.trailing)
//                        }
//                        .padding()
//                    }
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                    
//                    // HStack Section for Past Orders, Reviews, Bio
//                    HStack(spacing: 30) {
//                        VStack {
//                            Image(systemName: "cart.fill")
//                                .font(.title)
//                                .foregroundColor(.orange)
//                            Text("Past Orders")
//                                .font(.caption)
//                        }
//                        VStack {
//                            Image(systemName: "airplane")
//                                .font(.title)
//                                .foregroundColor(.orange)
//                            Text("Past Trips")
//                                .font(.caption)
//                        }
//                        VStack {
//                            Image(systemName: "star.fill")
//                                .font(.title)
//                                .foregroundColor(.orange)
//                            Text("Reviews")
//                                .font(.caption)
//                        }
//                        VStack {
//                            Image(systemName: "pencil.circle.fill")
//                                .font(.title)
//                                .foregroundColor(.orange)
//                            Text("Bio")
//                                .font(.caption)
//                        }
//                    }
//                    .frame(width: 400, height: 50)
//                    .padding(.vertical)
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                    
//                    // Other Profile Options (Work Hub, Documents, etc.)
//                    VStack(alignment: .leading) {
//                        ProfileOptionButton(icon: "briefcase.fill", title: "Work Hub")
//                        ProfileOptionButton(icon: "doc.fill", title: "Documents")
//                        ProfileOptionButton(icon: "creditcard.fill", title: "Payment")
//                        ProfileOptionButton(icon: "creditcard", title: "Plus Card")
//                        ProfileOptionButton(icon: "building.columns.fill", title: "Tax Info")
//                        ProfileOptionButton(icon: "person.crop.circle.fill", title: "Edit Account")
//                        ProfileOptionButton(icon: "umbrella.fill", title: "Insurance")
//                        ProfileOptionButton(icon: "lock.fill", title: "Security and Privacy")
//                        ProfileOptionButton(icon: "gearshape.fill", title: "App Settings")
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                }
//                .padding(.top)
//                .background(Color(UIColor.systemGroupedBackground))
//            }
//            .navigationTitle("Account")
//            
//            // Floating Button to switch apps
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        // Toggle between travel and shopping app modes using binding
//                        isTravelerApp.toggle()
//                    }) {
//                        Text(isTravelerApp ? "Switch to Shopping" : "Switch to Traveling")
//                            .fontWeight(.bold)
//                            .padding()
//                            .background(Color.black)
//                            .foregroundColor(.white)
//                            .cornerRadius(30)
//                    }
//                    .padding()
//                }
//            }
//        }
//    }
//}
//
//// Reusable button components for profile options
//struct ProfileOptionButton: View {
//    var icon: String
//    var title: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.title2)
//                .foregroundColor(.orange)
//                .padding(.leading)
//            
//            Text(title)
//                .font(.headline)
//                .padding(.leading)
//            
//            Spacer()
//            
//            Image(systemName: "chevron.right")
//                .font(.title2)
//                .foregroundColor(.gray)
//                .padding(.trailing)
//        }
//        .padding(.vertical, 10)
//        Divider() // Optional: To separate each option with a line
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(isTravelerApp: .constant(false))
//    }
//}
