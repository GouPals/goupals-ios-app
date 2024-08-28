import SwiftUI
import MapKit

struct OngoingView: View {
    struct Order: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let earnings: String
        let distance: String
        let rating: String
        let location: CLLocationCoordinate2D // Added location coordinate for each order
    }
    
    // This should be replaced by the data structure from the backend:
    @State var ongoingOrders = [
        Order(title: "Ongoing Order 1", description: "Item 1 description", earnings: "$500", distance: "12 mins drive / 500 meters", rating: "4.82", location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)),
        Order(title: "Ongoing Order 2", description: "Item 2 description", earnings: "$300", distance: "8 mins drive / 300 meters", rating: "4.75", location: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437))
    ]
    
    var body: some View {
        NavigationView {
            List(ongoingOrders) { order in
                NavigationLink(destination: InstructionView(order: order)) {
                    HStack(alignment: .top, spacing: 10) { 
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            VStack {
                                Text(order.title)
                                    .font(.headline)
                                
                                Text(order.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text(order.earnings)
                                    .font(.headline)
                                    .foregroundColor(.green)
                                
                                Spacer()
                                
                                Text(order.distance)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                HStack {
                                    Text(order.rating)
                                        .font(.subheadline)
                                    Text("⭐️")
                                }
                            }
                        }
                    }
                    .padding(10)
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .shadow(radius: 1)
                }
                .padding(.vertical, 5)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Ongoing Orders")
        }
    }
}


struct OngoingView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingView()
    }
}



