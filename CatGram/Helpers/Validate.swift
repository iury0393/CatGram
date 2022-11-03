//
//  Validate.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 28/10/22.
//

import Foundation

struct Validate {
    
    static func validateEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        if string.count == 0 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    static func validatePassword(_ string: String) -> Bool {
        let passFormat = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passPredicate = NSPredicate(format:"SELF MATCHES %@", passFormat)
        return passPredicate.evaluate(with: string)
    }
}




