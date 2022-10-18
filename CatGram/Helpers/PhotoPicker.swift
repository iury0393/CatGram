//
//  PhotoPicker.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    private let configuration: PHPickerConfiguration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    @Binding var isPresented: Bool
    @Binding var imageSelected: UIImage
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            if let itemProvider = results.first?.itemProvider {
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let imagePicked = image as? UIImage {
                        self.parent.imageSelected = imagePicked
                        self.parent.isPresented = false
                    }
                }
            }
            
        }
    }
}
