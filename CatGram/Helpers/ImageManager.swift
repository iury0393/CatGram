//
//  ImageManager.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 25/10/22.
//

import Foundation
import FirebaseStorage
import UIKit

class ImageManager {
    
    //MARK: - PROPERTIES
    
    static let instance = ImageManager()
    
    private var REF_STORE = Storage.storage()
    
    //MARK: - PUBLIC FUNCTIONS
    func uploadProfileImage(userID: String, image: UIImage) {
        let path = getProfileImagePath(userID: userID)
        
        uploadImage(path: path, image: image) { _ in }
    }
    
    //MARK: - PRIVATE FUNCTIONS
    private func getProfileImagePath(userID: String) -> StorageReference {
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STORE.reference(withPath: userPath)
        return storagePath
    }
    
    private func uploadImage(path: StorageReference, image: UIImage, handler: @escaping (_ success: Bool) -> ()) {
        
        var compression: CGFloat = 1.0 // Loops down by 0.05
        let maxFileSize: Int = 240 * 240 // Maximum file size that we want to save
        let maxCompression: CGFloat = 0.05 // Maximum compression we ever allow
        
        // Get image data
        guard var originalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            handler(false)
            return
        }
        
        // Check maximum file size
        while (originalData.count > maxFileSize) && (compression > maxCompression) {
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression) {
                originalData = compressedData
            }
            print(compression)
        }
        
        // Get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            handler(false)
            return
        }
        
        // Get photo metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Save data to path
        path.putData(finalData,metadata: metadata) { _, error in
            if let error = error {
                print("Error uploading image. \(error)")
                handler(false)
                return
            } else {
                handler(true)
                return
            }
        }
    }
}
