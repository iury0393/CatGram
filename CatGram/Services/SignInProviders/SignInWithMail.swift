//
//  SignInWithMail.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 26/10/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class SignInWithMail: NSObject {
    
    static let instance = SignInWithMail()
    var mailSignInView = MailSignInView()
    
    func startSignInWithEmailFlow(view: MailSignInView) {
        mailSignInView = view
        mailSignInView.connectToFirebase()
    }
    
    func startSignInCreateUser(email: String, password: String, handler: @escaping (_ success: Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("Error registering in Firebase")
                handler(false)
                return
            } else {
                print("Sucessfuly Registered")
                handler(true)
                return
            }
        }
    }
    
    func startSignInLogInUser(email: String, password: String, handler: @escaping (_ success: Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print("Error registering in Firebase")
                handler(false)
                return
            } else {
                print("Sucessfuly Registered")
                handler(true)
                return
            }
        }
    }
}
