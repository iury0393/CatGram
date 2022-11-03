//
//  CatGramApp.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 10/10/22.
//

import SwiftUI
import FirebaseCore

@main
struct CatGramApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
