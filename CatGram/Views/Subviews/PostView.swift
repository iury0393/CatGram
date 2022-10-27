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
    @State var postImage: UIImage = UIImage(named: "Cat1")!
    @State var animateLike: Bool = false
    @State var addHeartAnimationToView: Bool
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
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
                    ProfileView(posts: PostArrayObject(userID: post.userID), profilesDisplayName: post.username, profileUserID: post.userID, isMyProfile: false)
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
                
                Button {
                    showActionSheet.toggle()
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
                    .foregroundColor(post.likedByUser ? .red : .primary)
                    //MARK: - COMMENT ICON
                    NavigationLink {
                        CommentsView()
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
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
        
        PostView(post: post, showHeaderAndFooter: true, addHeartAnimationToView: true)
            .previewLayout(.sizeThatFits)
        
    }
}
