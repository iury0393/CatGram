//
//  ContentView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
    let feedPosts = PostArrayObject(shuffled: false)
    let browsePosts = PostArrayObject(shuffled: true)
    
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: feedPosts, title: "Feed")
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Feed")
            }
            NavigationView {
                BrowseView(posts: browsePosts)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text(Localization.Screens.ContentView.browseBar)
            }
            ZStack {
                UploadView()
                
            }
            .tabItem {
                Image(systemName: "square.and.arrow.up.fill")
                Text(Localization.Screens.ContentView.uploadBar)
            }
            ZStack {
                if let userID = currentUserID, let displayName = currentUserDisplayName {
                    NavigationView {
                        ProfileView(posts: PostArrayObject(userID: userID), profilesDisplayName: displayName, profileUserID: userID, isMyProfile: true)
                    }
                } else {
                    SignUpView()
                }
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text(Localization.Screens.ContentView.profileBar)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
