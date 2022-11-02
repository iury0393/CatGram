//
//  CommentModel.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import Foundation
import SwiftUI

struct CommentModel: Identifiable, Hashable {
    
    var id = UUID()
    var commentID: String // ID for the comment in the database
    var userID: String // ID for the user in the database
    var username: String // Username for the user in the database
    var content: String // Actually comment text
    var likedByUser: Bool
    var dateCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
