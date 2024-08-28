import SwiftUI

struct DiscoveryView: View {
    // Sample data for items (this should be replaced with real data)
    let items = [
        ("Item 1", "image1", "$100", "$20 saved", "This is item 1 description", 250.0),
        ("Item 2", "video2", "$150", "$30 saved", "This is item 2 description", 300.0),
        ("Item 3", "image3", "$80", "$10 saved", "This is item 3 description", 200.0),
        ("Item 4", "video4", "$200", "$40 saved", "This is item 4 description", 350.0),
        ("Item 5", "image5", "$120", "$25 saved", "This is item 5 description", 180.0),
        ("Item 6", "video6", "$90", "$15 saved", "This is item 6 description", 270.0)
    ]
    
    @State private var searchText = ""
    @State private var showMoreOptions = false

    var body: some View {
        NavigationView {
            VStack {
                // Search bar at the top
                TextField("Search for items...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.top)

                ScrollView {
                    LazyVStack(spacing: 10) {
                        // Iterate through items and arrange them in a flow layout
                        ForEach(0..<items.count/2) { index in
                            HStack(spacing: 10) {
                                createItemView(for: items[index * 2])
                                if index * 2 + 1 < items.count {
                                    createItemView(for: items[index * 2 + 1])
                                } else {
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
//            .navigationTitle("Discovery")
            .toolbar {
                // Top right cart button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Cart action
                    }) {
                        Image(systemName: "cart.fill")
                            .foregroundColor(.blue)
                    }
                }
                
                // Top right more options button (3 dots)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showMoreOptions.toggle()
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.blue)
                    }
                    .actionSheet(isPresented: $showMoreOptions) {
                        ActionSheet(
                            title: Text("More Options"),
                            buttons: [
                                .default(Text("Filter")) {
                                    // Filter action
                                },
                                .default(Text("Wishlist")) {
                                    // Wishlist action
                                },
                                .default(Text("Services")) {
                                    // Services action
                                },
                                .default(Text("Coupons")) {
                                    // Coupons action
                                },
                                .cancel()
                            ]
                        )
                    }
                }
            }
        }
    }
    
    // Helper function to create item view with varying height and fixed width (half screen width)
    func createItemView(for item: (String, String, String, String, String, Double)) -> some View {
        VStack(alignment: .leading) {
            if item.1.contains("image") {
                Image(item.1)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: item.5) // Varying height based on data
                    .frame(width: UIScreen.main.bounds.width / 2 - 20) // Fixed width (half screen width minus padding)
                    .clipped()
            } else {
                // Placeholder for video thumbnail
                Image(systemName: "video.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: item.5)
                    .frame(width: UIScreen.main.bounds.width / 2 - 20) // Fixed width (half screen width minus padding)
                    .clipped()
            }
            
            Text(item.0)
                .font(.headline)
                .bold()
                .padding(.top, 5)
            
            Text(item.4)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Price: \(item.2)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("\(item.3)")
                .font(.subheadline)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .frame(width: UIScreen.main.bounds.width / 2 - 20) // Fixed width (half screen width minus padding)
        .clipped()
    }
}
