//
//  PostView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 14/10/22.
//

import SwiftUI

struct PostView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showSignUpView: Bool = false
    
    @State var post: PostModel
    @State var animateLike: Bool = false
    @State var addHeartAnimationToView: Bool
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    @State var postImage: UIImage = UIImage(named: "logo.loading")!
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    // Alerts
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    var showHeaderAndFooter: Bool
    
    enum PostActionSheetOption {
        case general
        case reporting
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if showHeaderAndFooter {
            //MARK: - HEADER
            HStack {
                NavigationLink {
                    LazyView {
                        ProfileView(posts: PostArrayObject(userID: post.userID), profilesDisplayName: post.username, profileUserID: post.userID, isMyProfile: false)
                    }
                } label: {
                    Image(uiImage: profileImage)
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
                
                Button {
                    if currentUserID != nil {
                        showActionSheet.toggle()
                    } else {
                        showSignUpView = true
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.headline)
                }
                .actionSheet(isPresented: $showActionSheet, content: {
                    getActionSheet()
                })

            }
            .padding(.all, 6)
        }
            
            //MARK: - IMAGE
            ZStack {
                Image(uiImage: postImage)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture(count: 2) {
                        if !post.likedByUser {
                            likePost()
                        }
                    }
                
                if addHeartAnimationToView {
                    LikeAnimationView(animate: $animateLike)
                }
            }
            
            if showHeaderAndFooter {
                //MARK: - FOOTER
                HStack(alignment: .center, spacing: 20) {
                    
                    Button {
                        if currentUserID != nil {
                            if post.likedByUser {
                                unlikePost()
                            } else {
                                likePost()
                            }
                        } else {
                            showSignUpView = true
                        }
                    } label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    }
                    .foregroundColor(post.likedByUser ? .red : .primary)
                    //MARK: - COMMENT ICON
                    if currentUserID != nil {
                        NavigationLink {
                            CommentsView(post: post)
                        } label: {
                            Image(systemName: "bubble.middle.bottom")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    } else {
                        Button {
                            showSignUpView = true
                        } label: {
                            Image(systemName: "bubble.middle.bottom")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    }
                    //MARK: - SHARE ICON
                    Button(action: {
                        sharePost()
                    }, label: {
                        Image(systemName: "paperplane")
                            .font(.title3)
                            .foregroundColor(.primary)
                    })
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
        .onAppear {
            getImages()
        }
        .sheet(isPresented: $showSignUpView, onDismiss: {
            showSignUpView = false
            dismiss.callAsFunction()
        }) {
            SignUpView()
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                self.dismiss.callAsFunction()
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    //MARK: - FUNCTIONS
    
    func likePost() {
        
        guard let userID = currentUserID else {
            print("Cannot find userID while liking the post")
            return
        }
        
        // Update the local data
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount + 1, likedByUser: true)
        self.post = updatedPost
        
        // Animate UI
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            animateLike = false
        }
        
        // Update database
        DataService.instance.likePost(postID: post.postID, currentUserID: userID)
    }
    
    func unlikePost() {
        guard let userID = currentUserID else {
            print("Cannot find userID while unliking the post")
            return
        }
        
        // Update the local data
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount - 1, likedByUser: false)
        self.post = updatedPost
        
        // Update database
        DataService.instance.unlikePost(postID: post.postID, currentUserID: userID)
    }
    
    func getImages() {
        
        // Get profile image
        ImageManager.instance.downloadProfileImage(userID: post.userID) { returnedImage in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
        
        ImageManager.instance.downloadPostImage(postID: post.postID) { returnedImage in
            if let image = returnedImage {
                self.postImage = image
            }
        }
    }
    
    func getActionSheet() -> ActionSheet {
        
        switch self.actionSheetType {
        case .general:
            return ActionSheet(title: Text(Localization.Screens.PostView.actionText), message: nil, buttons: [
                .destructive(Text(Localization.Screens.PostView.actionReport), action: {
                    
                    self.actionSheetType = .reporting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showActionSheet.toggle()
                    }
                    
                }),
                
                    .default(Text(Localization.Screens.PostView.actionLearn), action: {
                    
                }),
                
                .cancel()
            ])
        case .reporting:
            return ActionSheet(title: Text(Localization.Screens.PostView.actionReportQuestion), message: nil, buttons: [
                
                .destructive(Text(Localization.Screens.PostView.actionReport1), action: {
                    reportPost(reason: "This is inappropriate")
                }),
                .destructive(Text(Localization.Screens.PostView.actionReport2), action: {
                    reportPost(reason: "This is spam")
                }),
                .destructive(Text(Localization.Screens.PostView.actionReport3), action: {
                    reportPost(reason: "It made me uncomfortable")
                }),

                .cancel({
                    self.actionSheetType = .general
                })
            ])
        }
    }
    
    func reportPost(reason: String) {
        print("REPORT POST NOW")
        
        DataService.instance.uploadReport(reason: reason, postID: post.postID) { success in
            if success {
                alertTitle = Localization.Screens.PostView.postViewAlertTitle1
                alertMessage = Localization.Screens.PostView.postViewAlertMessage1
                showAlert.toggle()
            } else {
                alertTitle = Localization.Screens.PostView.postViewAlertTitle2
                alertMessage = Localization.Screens.PostView.postViewAlertMessage2
                showAlert.toggle()
            }
        }
    }
    
    func sharePost() {
        
        let message = Localization.Screens.PostView.sharePost
        let image = postImage
        
        let activityViewController = UIActivityViewController(activityItems: [message, image], applicationActivities: nil)
        
        let viewController = UIApplication.shared.currentUIWindow()?.rootViewController
        
        viewController?.present(activityViewController, animated: true, completion: nil)
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        
        let post: PostModel = PostModel(postID: "", userID: "", username: "Iury Vasc", caption: "This is a test caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        PostView(post: post, addHeartAnimationToView: true, showHeaderAndFooter: true)
            .previewLayout(.sizeThatFits)
        
    }
}
