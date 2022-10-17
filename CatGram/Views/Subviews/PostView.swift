//
//  PostView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 14/10/22.
//

import SwiftUI

struct PostView: View {
    
    @State var post: PostModel
    var showHeaderAndFooter: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {        if showHeaderAndFooter {
            //MARK: - HEADER
            HStack {
                Image("Cat1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30, alignment: .center)
                    .cornerRadius(15)
                
                Text(post.username)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .font(.headline)
            }
            .padding(.all, 6)
        }
            
            //MARK: - IMAGE
            Image("Cat1")
                .resizable()
                .scaledToFit()
            
            if showHeaderAndFooter {
                //MARK: - FOOTER
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "heart")
                        .font(.title3)
                    //MARK: - COMMENT ICON
                    NavigationLink {
                        CommentsView()
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    Image(systemName: "paperplane")
                        .font(.title3)
                    Spacer()
                }
                .padding(.all, 6)
                
                if let caption = post.caption {
                    HStack {
                        Text(caption)
                        Spacer(minLength: 0)
                    }
                    .padding(.all, 6)
                }
            }
        })
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        
        let post: PostModel = PostModel(postID: "", userID: "", username: "Iury Vasc", caption: "This is a test caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        PostView(post: post, showHeaderAndFooter: true)
            .previewLayout(.sizeThatFits)
        
    }
}
