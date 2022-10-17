//
//  MessageView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import SwiftUI

struct MessageView: View {
    
    @State var comment: CommentModel
    
    var body: some View {
        HStack {
            //MARK: - PROFILE IMAGE
            Image("Cat2")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .cornerRadius(20)
            
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
            Spacer(minLength: 0)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    
   static var comment: CommentModel = CommentModel(commentID: "", userID: "", username: "Iury Vasc", content: "This photo is really cool. hahaha", dateCreated: Date())
    
    static var previews: some View {
        MessageView(comment: comment)
            .previewLayout(.sizeThatFits)
    }
}
