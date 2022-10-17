//
//  FeedView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 14/10/22.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var posts: PostArrayObject
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(posts.dataArray) { post in
                    PostView(post: post)
                }
            }
        }
        .navigationTitle("Feed")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView(posts: PostArrayObject())
            
        }
    }
}
