//
//  ContentView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.MyTheme.beigeColor)
    }
    
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: PostArrayObject(), title: "Feed")
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Feed")
            }
            NavigationView {
                BrowseView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text(Localization.Screens.ContentView.browseBar)
            }
            UploadView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text(Localization.Screens.ContentView.uploadBar)
                }
            ZStack {
                if currentUserID != nil {
                    NavigationView {
                        ProfileView(profilesDisplayName: Localization.Screens.ContentView.profileView, profileUserID: "", isMyProfile: true)
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
