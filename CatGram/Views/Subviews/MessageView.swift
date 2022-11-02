//
//  MessageView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import SwiftUI

struct MessageView: View {
    
    @State var comment: CommentModel
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    var post: PostModel
        
    var body: some View {
        HStack {
            //MARK: - PROFILE IMAGE
            NavigationLink {
                LazyView {
                    ProfileView(posts: PostArrayObject(userID: comment.userID), profilesDisplayName: comment.username, profileUserID: comment.userID, isMyProfile: false)
                }
            } label: {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
            }

            VStack(alignment: .leading, spacing: 4) {
                
                //MARK: - USER NAME
                Text(comment.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                //MARK: - CONTENT
                Text(comment.content)
                    .padding(.all, 10)
                    .foregroundColor(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)

            }
            
            //MARK: - LIKE COMMENT
            Button {
                if comment.likedByUser {
                    unlikeComment()
                } else {
                    likeComment()
                }
            } label: {
                Image(systemName: comment.likedByUser ? "heart.fill" : "heart")
                    .font(.title3)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
        }
        .onAppear {
            getProfileImage()
        }
    }
    
    //MARK: - FUNCTIONS
    
    func getProfileImage() {
        ImageManager.instance.downloadProfileImage(userID: comment.userID) { returnedImage in
            if let image = returnedImage {
                profileImage = image
            }
        }
    }
    
    func likeComment() {
        // Update the local data
        let updateComment = CommentModel(commentID: comment.commentID, userID: comment.userID, username: comment.username, content: comment.content, likedByUser: true, dateCreated: comment.dateCreated)
        self.comment = updateComment
        
        // Update database
        DataService.instance.likeComment(postID: post.postID, commentID: comment.commentID, currentUserID: comment.userID)
    }
    
    func unlikeComment() {
        // Update the local data
        let updateComment = CommentModel(commentID: comment.commentID, userID: comment.userID, username: comment.username, content: comment.content, likedByUser: false, dateCreated: comment.dateCreated)
        self.comment = updateComment
        
        // Update database
        DataService.instance.unlikeComment(postID: post.postID, commentID: comment.commentID, currentUserID: comment.userID)
    }
}

struct MessageView_Previews: PreviewProvider {
    
    static var comment: CommentModel = CommentModel(commentID: "", userID: "", username: "Iury Vasc", content: "This photo is really cool. hahaha", likedByUser: false, dateCreated: Date())
    
    static let post: PostModel = PostModel(postID: "", userID: "", username: "", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        MessageView(comment: comment, post: post)
            .previewLayout(.sizeThatFits)
    }
}
