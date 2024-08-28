import SwiftUI

struct BrowseView: View {
    // Sample data for designer brands
    let items = [
        ("Louis Vuitton", "louis_vuitton_image", "$20199"),
        ("Gucci", "gucci_image", "$15999"),
        ("Chanel", "chanel_image", "$18999"),
        ("Prada", "prada_image", "$13999"),
        ("Hermès", "hermes_image", "$24999"),
        ("Dior", "dior_image", "$17999")
    ]
    
    @State private var searchText = ""
    @State private var selectedCategory = "Recommended"
    @State private var showFilterOptions = false

    // Categories in English
    var categories = ["Recommended", "Bags", "Jewelry", "Shoes", "Watches", "Clothing"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Top navigation bar with category icons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            VStack {
                                Image(systemName: iconForCategory(category))
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(selectedCategory == category ? .orange : .gray)
                                
                                Text(category)
                                    .font(.footnote)
                                    .foregroundColor(selectedCategory == category ? .orange : .gray)
                            }
                            .padding(.vertical, 10)
                            .onTapGesture {
                                selectedCategory = category
                            }
                            Spacer(minLength: 30) // Add a spacer with minimum length
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Search bar at the top
                TextField("Search for items...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Grid view of items as buttons linking to store pages
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(filteredItems, id: \.0) { item in
                            NavigationLink(destination: StoreView(storeName: item.0)) {
                                VStack(alignment: .leading) {
                                    Image(item.1)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                    
                                    Text(item.0)
                                        .font(.headline)
                                        .bold()
                                    
                                    Text("Price: \(item.2)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar {
                // Top right filter button with orange color
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showFilterOptions.toggle()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.orange)
                    }
                    .actionSheet(isPresented: $showFilterOptions) {
                        ActionSheet(
                            title: Text("Filter Options"),
                            buttons: [
                                .default(Text("By Country")) {
                                    // Implement filtering by country
                                },
                                .default(Text("By Category")) {
                                    // Implement filtering by category
                                },
                                .cancel()
                            ]
                        )
                    }
                }
            }
        }
    }
    
    // Filtering the items based on search text
    var filteredItems: [(String, String, String)] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    // Function to assign icon for each category
    func iconForCategory(_ category: String) -> String {
        switch category {
        case "Recommended":
            return "star"
        case "Bags":
            return "bag"
        case "Jewelry":
            return "crown"
        case "Shoes":
            return "shoe.fill"  // Corrected icon for shoes
        case "Watches":
            return "clock.fill"  // Corrected icon for watches
        case "Clothing":
            return "tshirt"
        default:
            return "star"
        }
    }
}


struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
