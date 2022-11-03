//
//  LazyView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 30/10/22.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    
    var content: () -> Content
    
    var body: some View {
        content()
    }
}
