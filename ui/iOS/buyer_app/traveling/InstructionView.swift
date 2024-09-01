//
//  InstructionView.swift
//  buyer_app
//
//  Created by Jerry Cheng on 8/26/24.
//

import SwiftUI
import MapKit
import UIKit


// Image picker for selecting the images:
struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


// The actual instructions on how to get the items:
import SwiftUI
import MapKit
import AVKit // Import AVKit to handle video previews

struct InstructionView: View {
    var order: OngoingView.Order
    @State private var showFullMap = false
    
    // States for handling photo, video, and receipt uploads
    @State private var showImagePicker = false
    @State private var showVideoPicker = false
    @State private var showReceiptPicker = false
    @State private var showActionSheet = false
    @State private var showVideoActionSheet = false
    @State private var selectedImage: UIImage? = nil
    @State private var selectedReceipt: UIImage? = nil
    @State private var selectedVideoURL: URL? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Order Details: \(order.title)")
                    .font(.headline)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("1. Navigate to the Store")
                    
                    // Small Map Preview
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: order.location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))
                        .frame(height: 150)
                        .cornerRadius(8)
                        .onTapGesture {
                            showFullMap.toggle()
                        }
                        .sheet(isPresented: $showFullMap) {
                            FullMapView(location: order.location)
                        }
                    
                    Text("2. Item Details")
                    Text("Name: Example Item")
                    Text("Color: Red")
                    Text("Price: $100")
                    
                    // Upload Photo Button
                    Button("Upload Photo of the Item") {
                        showActionSheet = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose a method to upload the photo"), buttons: [
                            .default(Text("Take Photo")) {
                                sourceType = .camera
                                showImagePicker = true
                            },
                            .default(Text("Choose from Library")) {
                                sourceType = .photoLibrary
                                showImagePicker = true
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
                    }
                    
                    // Display the selected image
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(8)
                            .padding(.top)
                    }
                    
                    // Upload Video Button
                    Button("Upload Video of Packaging") {
                        showVideoActionSheet = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .actionSheet(isPresented: $showVideoActionSheet) {
                        ActionSheet(title: Text("Select Video"), message: Text("Choose a method to upload the video"), buttons: [
                            .default(Text("Record Video")) {
                                sourceType = .camera
                                showVideoPicker = true
                            },
                            .default(Text("Choose from Library")) {
                                sourceType = .photoLibrary
                                showVideoPicker = true
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $showVideoPicker) {
                        VideoPicker(selectedVideoURL: $selectedVideoURL, sourceType: sourceType)
                    }
                    
                    // Display the selected video
                    if let videoURL = selectedVideoURL {
                        VideoPlayer(player: AVPlayer(url: videoURL))
                            .frame(height: 200)
                            .cornerRadius(8)
                            .padding(.top)
                    }
                    
                    // Upload Receipt Button
                    Button("Upload Receipt") {
                        showReceiptPicker = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .actionSheet(isPresented: $showReceiptPicker) {
                        ActionSheet(title: Text("Select Receipt"), message: Text("Choose a method to upload the receipt"), buttons: [
                            .default(Text("Take Photo")) {
                                sourceType = .camera
                                showImagePicker = true
                            },
                            .default(Text("Choose from Library")) {
                                sourceType = .photoLibrary
                                showImagePicker = true
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedReceipt, sourceType: sourceType)
                    }
                    
                    // Display the selected receipt
                    if let receipt = selectedReceipt {
                        Image(uiImage: receipt)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(8)
                            .padding(.top)
                    }
                    
                    Text("6. Drop-off Instructions")
                    
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: order.location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))
                        .frame(height: 150)
                        .cornerRadius(8)
                        .onTapGesture {
                            showFullMap.toggle()
                        }
                        .sheet(isPresented: $showFullMap) {
                            FullMapView(location: order.location)
                        }
                }
                .padding()
            }
        }
    }
}


// Load navigation map view:
struct FullMapView: View {
    var location: CLLocationCoordinate2D
    
    @State private var region: MKCoordinateRegion
    @Environment(\.presentationMode) var presentationMode // To handle the back navigation
    
    init(location: CLLocationCoordinate2D) {
        self.location = location
        _region = State(initialValue: MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.all)
            
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Back action
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
                    .padding()
                }
                // push the button to the left
                Spacer()
            }
        }
    }
}

struct VideoPicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: VideoPicker

        init(parent: VideoPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let mediaURL = info[.mediaURL] as? URL {
                parent.selectedVideoURL = mediaURL
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedVideoURL: URL?
    var sourceType: UIImagePickerController.SourceType

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.mediaTypes = ["public.movie"]
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
