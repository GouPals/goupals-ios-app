//
//  ImagePicker.swift
//  buyer_app
//
//  Created by Jerry Cheng on 9/1/24.
//

import SwiftUI
import PhotosUI

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

//
//struct ImagePickerView: View {
//    @State private var selectedImage: UIImage?
//    @State private var isImagePickerPresented = false
//
//    // create the image picker type 
//    struct ImagePicker: UIViewControllerRepresentable {
//        @Binding var selectedImage: UIImage?
//
//        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//            var parent: ImagePicker
//
//            init(parent: ImagePicker) {
//                self.parent = parent
//            }
//
//            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//                if let uiImage = info[.originalImage] as? UIImage {
//                    parent.selectedImage = uiImage
//                }
//                picker.dismiss(animated: true)
//            }
//
//            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//                picker.dismiss(animated: true)
//            }
//        }
//
//        func makeCoordinator() -> Coordinator {
//            Coordinator(parent: self)
//        }
//
//        func makeUIViewController(context: Context) -> UIImagePickerController {
//            let picker = UIImagePickerController()
//            picker.delegate = context.coordinator
//            picker.sourceType = .photoLibrary
//            return picker
//        }
//
//        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//            // No need to update the view controller
//        }
//    }
//    
//    
//    var body: some View {
//        VStack {
//            if let selectedImage = selectedImage {
//                Image(uiImage: selectedImage)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(10)
//            } else {
//                Rectangle()
//                    .fill(Color.gray.opacity(0.2))
//                    .frame(width: 300, height: 300)
//                    .cornerRadius(10)
//                    .overlay(
//                        Text("Tap to select an image")
//                            .foregroundColor(.gray)
//                    )
//            }
//
//            Button("Select Image") {
//                isImagePickerPresented = true
//            }
//            .padding()
//        }
//        .sheet(isPresented: $isImagePickerPresented) {
//            ImagePicker(selectedImage: $selectedImage)
//        }
//    }
//}
