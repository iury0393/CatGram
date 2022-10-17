//
//  PostModel.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    
    var id = UUID()
    var postID: String // ID for the post in database
    var userID: String // ID for the user in databse
    var username: String // Username of the user in database
    var caption: String?
    var dateCreated: Date
    var likeCount: Int
    var likedByUser: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
