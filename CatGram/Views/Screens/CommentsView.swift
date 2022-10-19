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
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(commentArray) { comment in
                        MessageView(comment: comment)
                    }
                }
            }
            
            HStack {
                Image("Cat1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                
                TextField(Localization.Screens.CommentsView.commentPlaceholder, text: $submissionText, axis: .horizontal)
                
                Button {
                    
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
        }
    }
    //MARK: - FUNCTIONS
    
    func getComments() {
        let comment1 = CommentModel(commentID: "", userID: "", username: "Iury Vasc", content: "This is the first comment", dateCreated: Date())
        let comment2 = CommentModel(commentID: "", userID: "", username: "Lara", content: "This is the second comment", dateCreated: Date())
        let comment3 = CommentModel(commentID: "", userID: "", username: "Marina", content: "This is the third comment", dateCreated: Date())
        let comment4 = CommentModel(commentID: "", userID: "", username: "Stella", content: "This is the fourth comment", dateCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView()
        }
    }
}
