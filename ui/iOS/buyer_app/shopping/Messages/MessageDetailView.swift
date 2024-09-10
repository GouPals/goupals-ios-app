import SwiftUI
import Firebase



// MessageDetailView
struct MessageDetailView: View {
    
    @State private var messages: [String] = ["Hi, how can I help you?"]
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage? = nil
    
    @ObservedObject var vm = ChatLogViewModel() // No longer passing currentUser here
    
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
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Image(systemName: "photo.on.rectangle")
                        .font(.system(size: 24))
                        .foregroundColor(Color(.darkGray))
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                }
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
                
                ZStack(alignment: .topLeading) {
                    // TextEditor for typing the message
                    TextEditor(text: $vm.chatText)
                        .frame(minHeight: 10, maxHeight: 40) // Ensures a fixed initial height
                        .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    // Display the placeholder only if the message is empty
                    if vm.chatText.isEmpty {
                        Text("Send a message...")
                            .foregroundColor(.gray)
                            .padding(.leading, 6)
                            .padding(.top, 8)
                    }
                }

                Button {
                    vm.handleSend()
                    appendLocalMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 24))
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
    
    // Append the local message to the messages array (for UI update)
    private func appendLocalMessage() {
        if !vm.chatText.isEmpty {
            messages.append(vm.chatText)
            vm.chatText = ""
        }
    }
}


//import SwiftUI
//
//struct MessageDetailView: View {
//    var body: some View {
//        Text("Hello World")
//    }
//    
//}
