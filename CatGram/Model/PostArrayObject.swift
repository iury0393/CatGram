//
//  PostArrayObject.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import Foundation

class PostArrayObject: ObservableObject {
    
    @Published var dataArray = [PostModel]()
    
    init() {
        let post1 = PostModel(postID: "", userID: "", username: "Iury Vasc", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post2 = PostModel(postID: "", userID: "", username: "Lara", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post3 = PostModel(postID: "", userID: "", username: "Marina", caption: "This is a really really long caption hahahahahaha", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post4 = PostModel(postID: "", userID: "", username: "Stella", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
    
    /// USED FOR SINGLE POST SELECTION
    init(post: PostModel) {
        self.dataArray.append(post)
    }
    
    /// USED FOR GETTING POSTS FOR USERS PROFILE
    init(userID: String) {
        print("GET POSTS FOR USERID \(userID)")
        DataService.instance.downloadPostForUser(userID: userID) { returnedPosts in
            let sortedPosts = returnedPosts.sorted { post1, post2 in
                return post1.dateCreated > post2.dateCreated
            }
            self.dataArray.append(contentsOf: sortedPosts)
        }
    }
    
    /// USER FOR FEED
    init(shuffled: Bool) {
        
        print("GET POSTS FOR FEED. SHUFFLED: \(shuffled)")
        DataService.instance.downloadPostForFeed { returnedPosts in
            if shuffled {
                let shuffledPost = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shuffledPost)
            } else {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
    }
}
