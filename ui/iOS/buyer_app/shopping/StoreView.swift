import SwiftUI

struct StoreView: View {
    let storeName: String
    
    // Sample data for store items
    let storeItems = [
        ("Item 1", "item1_image", "This is the description of Item 1.", "$50"),
        ("Item 2", "item2_image", "This is the description of Item 2.", "$100"),
        ("Item 3", "item3_image", "This is the description of Item 3.", "$30"),
        ("Item 4", "item4_image", "This is the description of Item 4.", "$70")
    ]
    
    var body: some View {
        VStack {
            // Grid view of store items
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(storeItems, id: \.0) { item in
                        NavigationLink(destination: ItemView(itemName: item.0, itemImage: item.1, itemDescription: item.2, itemPrice: item.3)) {
                            VStack(alignment: .leading) {
                                Image(item.1)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                
                                Text(item.0)
                                    .font(.headline)
                                    .bold()
                                
                                Text(item.2)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                
                                Text(item.3)
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
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
        .navigationBarTitle(storeName, displayMode: .inline) // Title in the navigation bar
    }
}



