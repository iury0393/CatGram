//
//  ImageManager.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 25/10/22.
//

import Foundation
import FirebaseStorage
import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

class ImageManager {
    
    //MARK: - PROPERTIES
    
    static let instance = ImageManager()
    
    private var REF_STORE = Storage.storage()
    
    //MARK: - PUBLIC FUNCTIONS
    func uploadProfileImage(userID: String, image: UIImage) {
        
        // Get the path where we will save the image
        let path = getProfileImagePath(userID: userID)
        
        // Save image to path
        uploadImage(path: path, image: image) { _ in }
    }
    
    func uploadPostImage(postID: String, image: UIImage, handler: @escaping (_ success: Bool) -> ()) {
        
        // Get the path where we will save the image
        let path = getPostImagePath(postID: postID)
        
        // Save image to path
        uploadImage(path: path, image: image) { success in
            handler(success)
        }
    }
    
    func downloadProfileImage(userID: String, handler: @escaping (_ image: UIImage?) -> ()) {
        
        // Get the path where the image is saved
        let path = getProfileImagePath(userID: userID)
        
        // Download the image from path
        downloadImage(path: path) { returnedImage in
            handler(returnedImage)
        }
        
    }
    
    //MARK: - PRIVATE FUNCTIONS
    private func getProfileImagePath(userID: String) -> StorageReference {
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STORE.reference(withPath: userPath)
        return storagePath
    }
    
    private func getPostImagePath(postID: String) -> StorageReference {
        let postPath = "post/\(postID)/1"
        let storagePath = REF_STORE.reference(withPath: postPath)
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
    
    private func downloadImage(path: StorageReference, handler: @escaping (_ image: UIImage?) -> ()) {
        
        if let cachedImage = imageCache.object(forKey: path) {
            print("Image found in cache")
            handler(cachedImage)
            return
        } else {
            path.getData(maxSize: 27 * 1024 * 1024) { returnImageData, error in
                
                if let data = returnImageData, let image = UIImage(data: data) {
                    // Success getting image data
                    imageCache.setObject(image, forKey: path)
                    handler(image)
                    return
                } else {
                    print("Error getting data from path for image")
                    handler(nil)
                    return
                }
            }
        }
    }
}
