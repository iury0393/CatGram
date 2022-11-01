//
//  Enums & Structs.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 25/10/22.
//

import Foundation

struct DatabaseUserField { // Fields within the user document in database
    
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"
}

struct DatabasePostField { // Fields within post document in database
    
    static let postID = "post_id"
    static let userID = "user_id"
    static let displayName = "display_name"
    static let caption = "caption"
    static let dateCreated = "date_created"
    static let likeCount = "like_count" // INT
    static let likedBy = "liked_by" // Array
    static let comments = "comments" // Sub-collection
}

struct DatabaseCommentsField { // Fields within the comment sub-collection of a post document
    
    static let commentID = "comment_id"
    static let displayName = "display_name"
    static let userID = "user_id"
    static let content = "content"
    static let dateCreated = "date_created"
    
}

struct DatabaseReportsField { // Fields within Report Document in Database
    
    static let content = "content"
    static let postID = "post_id"
    static let dateCreated = "date_created"
    
}

struct CurrentUserDefaults { // Fields for UserDefaults saved within app
    
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
}

enum SettingsEditTextOption {
    case displayName
    case bio
}
