//
//  PostArrayObject.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import Foundation

class PostArrayObject: ObservableObject {
    
    @Published var dataArray = [PostModel]()
    
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
