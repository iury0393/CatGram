//
//  DataService.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 27/10/22.
//

// Used to handle upload and download data (other than User) from our database
import Foundation
import SwiftUI
import FirebaseFirestore

class DataService {
    
    //MARK: - PROPERTIES
    
    static let instance = DataService()
    private var REF_POSTS = DB_BASE.collection("posts")
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    //MARK: - CREATE FUNCTION
    
    func uploadPost(image: UIImage, caption: String?, displayName: String, userID: String, handler: @escaping (_ success: Bool) -> ()) {
        
        // Create new document
        let document = REF_POSTS.document()
        let postID = document.documentID
        
        // Upload image to Storage
        ImageManager.instance.uploadPostImage(postID: postID, image: image) { success in
            
            if success {
                // Successfuly uploaded image data to Storage
                // Now upload post data to Database
                
                let postData: [String: Any] = [
                    DatabasePostField.postID : postID,
                    DatabasePostField.userID : userID,
                    DatabasePostField.displayName : displayName,
                    DatabasePostField.caption : caption ?? "",
                    DatabasePostField.dateCreated : FieldValue.serverTimestamp(),
                ]
                
                document.setData(postData) { error in
                    if let error = error {
                        print("Error uploading data to post document/ \(error)")
                        handler(false)
                        return
                    } else {
                        // Return back to the app
                        handler(true)
                        return
                    }
                }
            } else {
                print("Error uploading post image to Firebase")
                handler(false)
                return
            }
        }
    }
    
    //MARK: - GET FUNCTIONS
    
    func downloadPostForUser(userID: String, handler: @escaping(_ posts: [PostModel]) -> ()) {
        REF_POSTS.whereField(DatabasePostField.userID, isEqualTo: userID).getDocuments { querySnapshot, error in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    func downloadPostForFeed(handler: @escaping(_ posts: [PostModel]) -> ()) {
        REF_POSTS.order(by: DatabasePostField.dateCreated, descending: true).limit(to: 50).getDocuments { querySnapshot, error in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    private func getPostsFromSnapshot(querySnapshot: QuerySnapshot?) -> [PostModel] {
        var postArray = [PostModel]()
        if let snapshot = querySnapshot, snapshot.documents.count > 0 {
            
            for document in snapshot.documents {
                if
                    let userID = document.get(DatabasePostField.userID) as? String,
                    let displayName = document.get(DatabasePostField.displayName) as? String,
                    let timeStamp = document.get(DatabasePostField.dateCreated) as? Timestamp {
                    
                    let postID = document.documentID
                    let caption = document.get(DatabasePostField.caption) as? String
                    let date = timeStamp.dateValue()
                    
                    let likeCount = document.get(DatabasePostField.likeCount) as? Int ?? 0
                    var likedByUser: Bool = false
                    if let userIDArray = document.get(DatabasePostField.likedBy) as? [String], let userID = currentUserID {
                        likedByUser = userIDArray.contains(userID)
                    }
                    
                    let newPost = PostModel(postID: postID, userID: userID, username: displayName, caption: caption, dateCreated: date, likeCount: likeCount, likedByUser: likedByUser)
                    postArray.append(newPost)
                }
            }
            return postArray
        } else {
            print("No documents in snapshot found for this user")
            return postArray
        }
    }
    
    //MARK: - UPDATE FUNCTIONS
    
    func likePost(postID: String, currentUserID: String) {
        // Update the post count
        // Update the array of users who liked the post
        
        let increment: Int64 = 1
        let data: [String: Any] = [
            DatabasePostField.likeCount: FieldValue.increment(increment),
            DatabasePostField.likedBy: FieldValue.arrayUnion([currentUserID]),
        ]
        
        REF_POSTS.document(postID).updateData(data)
    }
    
    func unlikePost(postID: String, currentUserID: String) {
        // Update the post count
        // Update the array of users who liked the post
        
        let subtract: Int64 = -1
        let data: [String: Any] = [
            DatabasePostField.likeCount: FieldValue.increment(subtract),
            DatabasePostField.likedBy: FieldValue.arrayRemove([currentUserID]),
        ]
        
        REF_POSTS.document(postID).updateData(data)
    }
}
