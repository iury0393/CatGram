//
//  BrowseView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import SwiftUI

struct BrowseView: View {
    
    var posts: PostArrayObject
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            CarousselView(posts: posts)
            ImageGridView(posts: posts)
        }
        .navigationTitle(Localization.Screens.ContentView.browseBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrowseView(posts: PostArrayObject(shuffled: false))
        }
    }
}
