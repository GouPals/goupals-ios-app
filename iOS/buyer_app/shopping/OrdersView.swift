import SwiftUI

struct OrdersView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var selectedCategory = "Cart"
    
    // Sample data for items in cart (you can replace this with real data)
    let items = [
        ("Item 1", "item_image_1", "This is item 1 description", "$100", "$20 saved"),
        ("Item 2", "item_image_2", "This is item 2 description", "$80", "$10 saved"),
        ("Item 3", "item_image_3", "This is item 3 description", "$50", "$5 saved")
    ]
    
    var categories = ["Cart", "Past Orders", "Ongoing Orders", "To Be Reviewed"]
    
    // Calculate the total price and total saved (this is a simple example)
    var totalPrice: String {
        let prices = items.compactMap { item in
            Double(item.3.replacingOccurrences(of: "$", with: ""))
        }
        let total = prices.reduce(0, +)
        return "$\(String(format: "%.2f", total))"
    }
    
    var totalSaved: String {
        let savings = items.compactMap { item in
            Double(item.4.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: " saved", with: ""))
        }
        let total = savings.reduce(0, +)
        return "$\(String(format: "%.2f", total))"
    }
    
    var body: some View {
        VStack {
            // Top bar with search bar and edit button
            HStack {
                TextField("Search Orders...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.leading)
                
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Done" : "Edit")
                        .foregroundColor(.orange)
                        .padding(.trailing)
                }
            }
            .padding(.top)
            
            // Static buttons with icons for order categories, equally spaced
            HStack {
                Spacer()
                
                ForEach(categories, id: \.self) { category in
                    VStack {
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Image(systemName: iconForCategory(category))
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedCategory == category ? .orange : .gray)
                        }
                        Text(labelForCategory(category))
                            .font(.footnote)
                            .foregroundColor(selectedCategory == category ? .orange : .gray)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            // List view of items with photos, descriptions, prices, and saved amounts
            List {
                ForEach(items, id: \.0) { item in
                    HStack {
                        Image(item.1)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.0)
                                .font(.headline)
                            Text(item.2)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Price: \(item.3)")
                                .font(.subheadline)
                            Text(item.4)
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                        Spacer()
                    }
                    .padding() // Added padding around each item
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                }
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal)
            
            // Bottom section with total price, total saved, and checkout button
            HStack {
                VStack {
                    Text("Total: \(totalPrice)")
                        .font(.headline)
                        .padding(.leading)
                    
//                    Spacer()
                    
                    Text("Total Saved: \(totalSaved)")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.trailing)
                }
                .padding(.top)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // Implement checkout action
                    }) {
                        Text("Checkout")
                            .font(.headline)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.trailing)
                }
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: -5)
        }
        .navigationTitle("Orders")
    }
    
    // Function to assign icons for each category
    func iconForCategory(_ category: String) -> String {
        switch category {
        case "Cart":
            return "cart.fill"
        case "Past Orders":
            return "clock.fill"
        case "Ongoing Orders":
            return "clock.arrow.circlepath"
        case "To Be Reviewed":
            return "checkmark.circle.fill"
        default:
            return "cart.fill"
        }
    }
    
    // Function to assign labels for each category
    func labelForCategory(_ category: String) -> String {
        switch category {
        case "Cart":
            return "Cart"
        case "Past Orders":
            return "Past"
        case "Ongoing Orders":
            return "Ongoing"
        case "To Be Reviewed":
            return "To Review"
        default:
            return ""
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
