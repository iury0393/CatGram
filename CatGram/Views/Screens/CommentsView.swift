//
//  CommentsView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import SwiftUI

struct CommentsView: View {
    
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    var post: PostModel
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName: String?
    
    var body: some View {
        VStack {
            
            // Messages ScrollView
            ScrollView {
                LazyVStack {
                    ForEach(commentArray) { comment in
                        MessageView(comment: comment, post: post)
                    }
                }
            }
            
            // Bottom Stack
            HStack {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                
                TextField(Localization.Screens.CommentsView.commentPlaceholder, text: $submissionText, axis: .horizontal)
                
                Button {
                    if textIsAppropriate() {
                        addComment()
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                }
            }
            .padding(.all, 6)
        }
        .navigationTitle(Localization.Screens.CommentsView.commentBar)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getComments()
            getProfilePicture()
        }
    }
    //MARK: - FUNCTIONS
    
    func getProfilePicture() {
        
        guard let userID = currentUserID else { return }
        
        ImageManager.instance.downloadProfileImage(userID: userID) { returnedImage in
            if let image = returnedImage {
                profileImage = image
            }
        }
    }
    
    func getComments() {
        
        guard commentArray.isEmpty else { return }
        
        if let caption = post.caption, caption.count > 1 {
            let captionComment = CommentModel(commentID: "", userID: post.userID, username: post.username, content: caption, likedByUser: post.likedByUser, dateCreated: post.dateCreated)
            commentArray.append(captionComment)
        }
        DataService.instance.downloadComments(postID: post.postID) { returnedComments in
            commentArray.append(contentsOf: returnedComments)
        }
    }
    
    func textIsAppropriate() -> Bool {
        // Check if the text has curses
        // Check if the text is long enough
        // Check if the text is blank
        // Check for innapropriate things
        let badWordArray: [String] = ["shit", "ass"]
        
        let words = submissionText.components(separatedBy: " ")
        
        for word in words {
            if badWordArray.contains(word) {
                return false
            }
        }
        
        if submissionText.count < 3 {
            return false
        }
        
        return true
    }
    
    func addComment() {
        
        guard let userID = currentUserID, let displayName = currentDisplayName else { return }
        
        DataService.instance.uploadComment(postID: post.postID, content: submissionText, displayName: displayName, userID: userID) { success, returnedCommentID in
            if success, let commentID = returnedCommentID {
                
                let newComment = CommentModel(commentID: commentID, userID: userID, username: displayName, content: submissionText, likedByUser: false, dateCreated: Date())
                commentArray.append(newComment)
                submissionText = ""
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    
    static let post = PostModel(postID: "", userID: "", username: "", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        NavigationView {
            CommentsView(post: post)
        }
    }
}
