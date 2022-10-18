//
//  ImagePicker.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import Foundation
import SwiftUI

struct CameraPicker: UIViewControllerRepresentable {
    
    @Environment(\.dismiss) private var dismissView
    @Binding var imageSelected: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<CameraPicker>) {}
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(parent: self)
    }
    
    class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let parent: CameraPicker
        
        init(parent: CameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                
                parent.imageSelected = image
                parent.dismissView.callAsFunction()
            }
        }
    }
}
