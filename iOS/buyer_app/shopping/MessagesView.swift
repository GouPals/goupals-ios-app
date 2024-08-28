//
//  MessagesView.swift
//  trader_app
//
//  Created by Jerry Cheng on 8/20/24.
//
import SwiftUI

struct MessagesView: View {
    @State private var isEditing = false
    @State private var selectedMessages = Set<Int>()
    @State private var showWriteMessageView = false
    @State private var showNotifications = false
    @State private var showRecentlyDeleted = false
    @State private var messages: [Message] = Array(0..<10).map { Message(id: $0, buyerName: "Buyer Name \($0 + 1)", lastMessage: "Last message preview...", isShown: false) }
    @State private var recentlyDeletedMessages: [Message] = []
    @State private var showDropdown = false
    @State private var dropdownOffset: CGSize = .zero
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                VStack {
                    SearchBar(text: $searchText)
                    
                    if showRecentlyDeleted {
                        List {
                            ForEach(recentlyDeletedMessages.indices, id: \.self) { index in
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.trailing, 10)
                                    
                                    VStack(alignment: .leading) {
                                        Text(recentlyDeletedMessages[index].buyerName)
                                            .font(.headline)
                                        Text(recentlyDeletedMessages[index].lastMessage)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .swipeActions {
                                    Button(role: .none) {
                                        recoverMessage(at: index)
                                    } label: {
                                        Label("Recover", systemImage: "arrow.uturn.left")
                                    }
                                    .tint(.blue)
                                }
                            }
                        }
                        .navigationTitle("Recently Deleted")
                        .toolbar {
                            // Back button in recently deleted view
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    showRecentlyDeleted = false
                                }) {
                                    Image(systemName: "arrow.left")
                                }
                            }
                        }
                    } else {
                        List(selection: $selectedMessages) {
                            ForEach(filteredMessages.indices, id: \.self) { index in
                                if !messages[index].isShown {
                                    HStack {
                                        if isEditing {
                                            Image(systemName: selectedMessages.contains(index) ? "checkmark.circle.fill" : "circle")
                                                .onTapGesture {
                                                    if selectedMessages.contains(index) {
                                                        selectedMessages.remove(index)
                                                    } else {
                                                        selectedMessages.insert(index)
                                                    }
                                                }
                                        }
                                        
                                        if !isEditing {
                                            NavigationLink(destination: MessageDetailView()) {
                                                HStack {
                                                    Image(systemName: "person.crop.circle.fill")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.trailing, 10)
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(messages[index].buyerName)
                                                            .font(.headline)
                                                        Text(messages[index].lastMessage)
                                                            .font(.subheadline)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                            }
                                        } else {
                                            HStack {
                                                Image(systemName: "person.crop.circle.fill")
                                                    .resizable()
                                                    .frame(width: 40, height: 40)
                                                    .padding(.trailing, 10)
                                                
                                                VStack(alignment: .leading) {
                                                    Text(messages[index].buyerName)
                                                        .font(.headline)
                                                    Text(messages[index].lastMessage)
                                                        .font(.subheadline)
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                            .onTapGesture {
                                                if selectedMessages.contains(index) {
                                                    selectedMessages.remove(index)
                                                } else {
                                                    selectedMessages.insert(index)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Show Delete button when editing and items are selected
                    if isEditing && !selectedMessages.isEmpty && !showRecentlyDeleted {
                        Button(action: {
                            deleteSelectedMessages()
                        }) {
                            Text("Delete")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                }
                
                if showDropdown {
                    VStack {
                        VStack {
                            Button("Select") {
                                withAnimation {
                                    isEditing = true
                                    showDropdown = false
                                }
                            }
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                            
                            Divider()
                            
                            Button("Recently Deleted") {
                                showRecentlyDeleted.toggle()
                                showDropdown = false
                            }
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .frame(width: 150)
                    }
                    .offset(x: dropdownOffset.width, y: dropdownOffset.height)
                    .scaleEffect(showDropdown ? 1 : 0.1, anchor: .topLeading)
                    .zIndex(1) // Ensure the dropdown stays on top
                    .transition(.scale(scale: 0.1, anchor: .topLeading).combined(with: .opacity))
                    .animation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0))
                }
            }
            .navigationTitle(showRecentlyDeleted ? "Recently Deleted" : "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Change between 3 dots and Done button
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEditing {
                        Button(action: {
                            withAnimation {
                                isEditing = false
                                selectedMessages.removeAll()
                            }
                        }) {
                            Text("Done")
                                .bold()
                        }
                    } else if !showRecentlyDeleted {
                        Button(action: {
                            withAnimation {
                                showDropdown.toggle()
                            }
                        }) {
                            Image(systemName: "ellipsis")
                        }
                        .background(GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    // Capture the position of the button to position the dropdown
                                    let buttonFrame = geometry.frame(in: .global)
                                    // Adjust the offset to place the dropdown at the bottom right of the button
                                    dropdownOffset = CGSize(width: buttonFrame.maxX + 25, height: buttonFrame.maxY - 25)
                                }
                        })
                    }
                }

                // Notifications and write buttons on the top right
                if !showRecentlyDeleted {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action: {
                                showNotifications.toggle()
                            }) {
                                Image(systemName: "bell")
                            }

                            Button(action: {
                                showWriteMessageView.toggle()
                            }) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showWriteMessageView) {
                // Show a simple message compose view (can be extended)
                VStack {
                    TextField("Enter your message...", text: .constant(""))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding()

                    Button("Send") {
                        // Action to send the message
                        showWriteMessageView = false
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
            }
            .sheet(isPresented: $showNotifications) {
                // Notifications view placeholder (can be extended)
                VStack {
                    Text("Notifications")
                        .font(.largeTitle)
                        .padding()

                    Spacer()
                }
            }
        }
    }
    
    var filteredMessages: [Message] {
        if searchText.isEmpty {
            return messages
        } else {
            return messages.filter { $0.buyerName.contains(searchText) || $0.lastMessage.contains(searchText) }
        }
    }
    
    func deleteMessages(at offsets: IndexSet) {
        for index in offsets {
            moveToRecentlyDeleted(index: index)
        }
    }
    
    func deleteSelectedMessages() {
        for index in selectedMessages {
            if messages.indices.contains(index) {
                moveToRecentlyDeleted(index: index)
            }
        }
        selectedMessages.removeAll()
        isEditing = false
    }
    
    func moveToRecentlyDeleted(index: Int) {
        var message = messages[index]
        message.isShown = true
        recentlyDeletedMessages.append(message)
        messages.remove(at: index)
    }
    
    func recoverMessage(at index: Int) {
        var message = recentlyDeletedMessages[index]
        message.isShown = false
        messages.append(message)
        recentlyDeletedMessages.remove(at: index)
    }
}

struct Message: Identifiable {
    var id: Int
    var buyerName: String
    var lastMessage: String
    var isShown: Bool
}

struct MessageDetailView: View {
    @State private var messages: [String] = ["Hi, how can I help you?"]
    @State private var userMessage: String = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages, id: \.self) { message in
                        HStack {
                            if message == messages.first {
                                Text(message)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text(message)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGray6))

            HStack {
                TextField("Type a message...", text: $userMessage)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 24))
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
    }

    func sendMessage() {
        if !userMessage.isEmpty {
            // Add user's message to the conversation
            messages.append(userMessage)
            userMessage = ""

            // Simulate a reply from the system
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                messages.append("Hi, how can I help you?")
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
        .padding(.top, 10)
    }
}
