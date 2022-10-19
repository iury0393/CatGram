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
    @State var animateLike: Bool = false
    @State var addHeartAnimationToView: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if showHeaderAndFooter {
            //MARK: - HEADER
            HStack {
                NavigationLink {
                    ProfileView(profilesDisplayName: post.username, profileUserID: post.userID, isMyProfile: false)
                } label: {
                    Image("Cat1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(15)
                    
                    Text(post.username)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .font(.headline)
            }
            .padding(.all, 6)
        }
            
            //MARK: - IMAGE
            ZStack {
                Image("Cat1")
                    .resizable()
                .scaledToFit()
                
                if addHeartAnimationToView {
                    LikeAnimationView(animate: $animateLike)
                }
            }
            
            if showHeaderAndFooter {
                //MARK: - FOOTER
                HStack(alignment: .center, spacing: 20) {
                    
                    Button {
                        if post.likedByUser {
                            unlikePost()
                        } else {
                            likePost()
                        }
                    } label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    }
                    .foregroundColor(post.likedByUser ? .red : .black)
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
        }
    }
    
    //MARK: - FUNCTIONS
    
    func likePost() {
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount + 1, likedByUser: true)
        self.post = updatedPost
        
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            animateLike = false
        }
    }
    
    func unlikePost() {
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount - 1, likedByUser: false)
        self.post = updatedPost
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        
        let post: PostModel = PostModel(postID: "", userID: "", username: "Iury Vasc", caption: "This is a test caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        PostView(post: post, showHeaderAndFooter: true, addHeartAnimationToView: true)
            .previewLayout(.sizeThatFits)
        
    }
}
