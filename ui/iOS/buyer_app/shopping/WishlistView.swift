import SwiftUI

struct WishlistView: View {
    @State private var wishlistItems = [
        WishlistItem(title: "Product 1", description: "Description of product 1", price: 19.99, imageName: "item1_image"),
        WishlistItem(title: "Product 2", description: "Description of product 2", price: 29.99, imageName: "item2_image"),
        WishlistItem(title: "Product 3", description: "Description of product 3", price: 49.99, imageName: "item3_image")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all) // Ensure the entire background is white

                List {
                    ForEach(wishlistItems) { item in
                        NavigationLink(destination: ItemView(itemName: item.title, itemImage: item.imageName, itemDescription: item.description, itemPrice: String(format: "$%.2f", item.price))) {
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.title)
                                        .font(.headline)
                                        .bold()
                                    
                                    Text(item.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Text("$\(item.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.orange)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: removeItems)
                    .listRowBackground(Color.clear)
                }
                .background(Color.white) // Ensure the list's background is white
            }
            .navigationTitle("Wishlist")
            .toolbar {
                EditButton()
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        wishlistItems.remove(atOffsets: offsets)
    }
}

struct WishlistItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let price: Double
    let imageName: String
}



//
//struct ItemView: View {
//    let itemName: String
//    let itemImage: String
//    let itemDescription: String
//    let itemPrice: String
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                // Image section
//                Image(itemImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(maxWidth: .infinity)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(12)
//                    .padding(.horizontal)
//                
//                // Details section
//                VStack(alignment: .leading, spacing: 15) {
//                    Text(itemName)
//                        .font(.title2)
//                        .bold()
//                    
//                    Text(itemDescription)
//                        .font(.body)
//                        .foregroundColor(.gray)
//                    
//                    Text(itemPrice)
//                        .font(.title)
//                        .foregroundColor(.orange)
//                        .bold()
//                    
//                    Spacer()
//                    
//                    // Add to Cart and Buy Now buttons
//                    HStack(spacing: 15) {
//                        Button(action: {
//                            // Add to cart action
//                        }) {
//                            Text("Add to Cart")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.yellow)
//                                .cornerRadius(10)
//                                .foregroundColor(.white)
//                        }
//                        
//                        Button(action: {
//                            // Buy now action
//                        }) {
//                            Text("Buy Now")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.orange)
//                                .cornerRadius(10)
//                                .foregroundColor(.white)
//                        }
//                    }
//                    .padding(.top, 20)
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//            .background(Color(.systemGray6))
//        }
//        .navigationBarTitle("Product Details", displayMode: .inline)
//    }
//}
