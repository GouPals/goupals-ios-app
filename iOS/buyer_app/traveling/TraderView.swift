//
//  OrdersView.swift
//  trader_app
//
//  Created by Jerry Cheng on 8/20/24.
//

import SwiftUI
import MapKit

struct TraderView: View {
    @State private var showMapView = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    struct Order: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let payment: Double
        let distance: Double
        let estimatedTime: String
        var status: OrderStatus
    }
    
    enum OrderStatus {
        case new, accepted, taken, rejected
    }
    
    @State private var orders = [
        Order(title: "Order 1", description: "Item 1 description", payment: 50.0, distance: 5.0, estimatedTime: "15 mins", status: .new),
        Order(title: "Order 2", description: "Item 2 description", payment: 75.0, distance: 10.0, estimatedTime: "25 mins", status: .new),
        Order(title: "Order 3", description: "Item 3 description", payment: 30.0, distance: 3.0, estimatedTime: "10 mins", status: .new)
    ]
    
    var body: some View {
        NavigationView {
            List {
                // Map preview at the top of the list
                ZStack {
                    Map(coordinateRegion: $region)
                        .frame(height: 150)
                        .cornerRadius(8)

                    // Circular button to expand map view
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                showMapView.toggle()
                            }) {
                                Image(systemName: "safari.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
                .sheet(isPresented: $showMapView) {
                    TraderMapView(orders: $orders)
                }
                .padding(.bottom, 10)
                
                // List of new orders
                ForEach(filteredOrders) { order in
                    HStack(alignment: .top, spacing: 10) {
                        // Image on the left
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            // Title and description in a vertical stack
                            VStack {
                                Text(order.title)
                                    .font(.headline)
                                
                                Text(order.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            // Payment, distance, and estimated time in another horizontal stack
                            HStack {
                                Text("$\(order.payment, specifier: "%.2f")")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                
                                Spacer()
                                
                                Text("\(order.distance, specifier: "%.2f") miles")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text(order.estimatedTime)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(10)
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .shadow(radius: 1)
                    .padding(.vertical, 5) // Padding between each item
                    .swipeActions(edge: .leading) {
                        Button {
                            acceptOrder(order)
                        } label: {
                            Label("Accept", systemImage: "checkmark")
                        }
                        .tint(.green)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("New Orders")
        }
    }
    
    var filteredOrders: [Order] {
        // Filter orders to only show new orders
        return orders.filter { $0.status == .new }
    }
    
    func acceptOrder(_ order: Order) {
        if let index = orders.firstIndex(where: { $0.id == order.id }) {
            orders[index].status = .accepted
        }
    }
}


struct TraderMapView: View {
    @Binding var orders: [TraderView.Order]
    @Environment(\.presentationMode) var presentationMode // To handle the back button
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        ZStack {
            // Map view
            Map(coordinateRegion: $region, annotationItems: orders) { order in
                MapPin(coordinate: CLLocationCoordinate2D(latitude: 37.7749 + Double(order.id.uuidString.hash % 100) * 0.001, longitude: -122.4194 + Double(order.id.uuidString.hash % 100) * 0.001))
            }
            .edgesIgnoringSafeArea(.all)
            
            // Back button overlay
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Action to go back to OrdersView
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding()
                   Spacer()
                }
//                .padding(.top, 50) // Adjust padding to place it properly
                Spacer()
            }
        }
        .navigationTitle("Map View")
        .navigationBarHidden(true) // Hide the default navigation bar to use the custom back button
    }
}

