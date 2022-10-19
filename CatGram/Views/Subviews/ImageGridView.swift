//
//  ImageGridView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import SwiftUI

struct ImageGridView: View {
    
    @ObservedObject var posts: PostArrayObject
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]) {
            ForEach(posts.dataArray) { post in
                NavigationLink {
                    FeedView(posts: PostArrayObject(post: post), title: "Post")
                } label: {
                    PostView(post: post, showHeaderAndFooter: false, addHeartAnimationToView: false)
                }
            }
        }
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(posts: PostArrayObject())
            .previewLayout(.sizeThatFits)
    }
}
