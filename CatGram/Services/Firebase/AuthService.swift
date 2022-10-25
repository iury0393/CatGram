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

class AuthService {
    
    //MARK: - PROPERTIES
    
    static let instance = AuthService()
    
    
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
}
