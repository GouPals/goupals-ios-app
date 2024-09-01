//
//  ItemView.swift
//  buyer_app
//
//  Created by Jerry Cheng on 8/27/24.
//

import SwiftUI

struct ItemView: View {
    let itemName: String
    let itemImage: String
    let itemDescription: String
    let itemPrice: String
    
    var body: some View {
        VStack {
            // Image section
            Image(itemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .background(Color.white)
            
            // Details section
            VStack(alignment: .leading, spacing: 15) {
                Text(itemPrice)
                    .font(.title)
                    .foregroundColor(.orange)
                    .bold()
                
                Text(itemName)
                    .font(.title2)
                    .bold()
                
                Text(itemDescription)
                    .font(.body)
                    .foregroundColor(.gray)
                
                Spacer()
                
                // Add to cart and Buy now buttons
                HStack(spacing: 20) {
                    Button(action: {
                        // Add to cart action
                    }) {
                        Text("Add to Cart")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        // Buy now action
                    }) {
                        Text("Buy Now")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarTitle("Product Details", displayMode: .inline)
        .background(Color.white)
    }
}

