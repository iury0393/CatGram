//
//  AuthService.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 25/10/22.
//

// Used to Authenticate users in Firebase
// Used to handle user accounts in Firebase

import Foundation
import FirebaseAuth
import UIKit
import FirebaseFirestore

let DB_BASE = Firestore.firestore()

class AuthService {
    
    //MARK: - PROPERTIES
    
    static let instance = AuthService()
    
    private var REF_USERS = DB_BASE.collection("users")
    
    
    //MARK: - AUTH USER FUNCTIONS
    
    func logInUserToFirebase(credential: AuthCredential, handler: @escaping (_ providerID: String?, _ isError: Bool) -> ()) {
        
        Auth.auth().signIn(with: credential) { (result, error) in
            
            if error != nil {
                print("Error logging in Firebase")
                handler(nil, true)
                return
            }
            
            guard let providerID = result?.user.uid else {
                print("Error getting providerID")
                handler(nil, true)
                return
            }
            
            handler(providerID, false)
        }
    }
    
    func createNewUserInDatabase(name: String, email: String, providerID: String, provider: String, profileImage: UIImage, handler: @escaping (_ userID: String?) -> ()) {
        
        // Set up a user document with user collection
        let document = REF_USERS.document()
        let userID = document.documentID
        
        // Upload profile image to Storage
        ImageManager.instance.uploadProfileImage(userID: userID, image: profileImage)
        
        // Upload profile to Firestore
        let userData: [String: Any] = [
            DatabaseUserField.displayName : name,
            DatabaseUserField.email : email,
            DatabaseUserField.providerID : providerID,
            DatabaseUserField.provider : provider,
            DatabaseUserField.userID : userID,
            DatabaseUserField.bio : "",
            DatabaseUserField.dateCreated : FieldValue.serverTimestamp(),
        ]
        
        document.setData(userData) { error in
            
            if let error = error {
                print("Error uploading data to user document. \(error)")
                handler(nil)
            } else {
                handler(userID)
            }
            
        }
        
    }
}
