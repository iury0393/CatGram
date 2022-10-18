//
//  ProfileView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct ProfileView: View {
    
    var posts = PostArrayObject()
    @State var profilesDisplayName: String
    var profileUserID: String
    var isMyProfile: Bool
    
    var body: some View {
        ScrollView{
            ProfileHeaderView(profileDisplayName: $profilesDisplayName)
            Divider()
            ImageGridView(posts: posts)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "line.horizontal.3")
            }
            .opacity(isMyProfile ? 1.0 : 0.0)

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(profilesDisplayName: "Joe", profileUserID: "", isMyProfile: true)
        }
    }
}
