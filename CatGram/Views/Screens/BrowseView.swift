//
//  BrowseView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import SwiftUI

struct BrowseView: View {
    
    private var posts = PostArrayObject()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            CarousselView()
            ImageGridView(posts: posts)
        }
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrowseView()
        }
    }
}
