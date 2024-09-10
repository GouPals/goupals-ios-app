//
//  MessageView.swift
//  buyer_app
//
//  Created by Jerry Cheng on 9/2/24.
//

import SwiftUI

struct MessageView: View {
    
    @ObservedObject var vm = MainMessageViewModel()
    
    
    var body: some View {
        Text("Current User ID is: \(vm.errorMessage)")
    }
}

