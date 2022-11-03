//
//  Extensions.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 14/10/22.
//

import Foundation
import SwiftUI

extension Color {
    
    struct MyTheme {
        
        static var purpleColor: Color {
            return Color("ColorPurple")
        }
        static var pinkColor: Color {
            return Color("ColorPink")
        }
        static var beigeColor: Color {
            return Color("ColorBeige")
        }
    }
}

extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }
        
        return window
        
    }
}
