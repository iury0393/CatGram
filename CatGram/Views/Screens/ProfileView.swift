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
    
    @State var showSettings = false
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    var body: some View {
        ScrollView{
            ProfileHeaderView(profileDisplayName: $profilesDisplayName, profileImage: $profileImage)
            Divider()
            ImageGridView(posts: posts)
        }
        .navigationTitle(Localization.Screens.ContentView.profileBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                showSettings.toggle()
            } label: {
                Image(systemName: "line.horizontal.3")
            }
            .opacity(isMyProfile ? 1.0 : 0.0)

        }
        .onAppear {
            getProfileImage()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
    
    //MARK: - FUNCTIONS
    
    func getProfileImage() {
        
        ImageManager.instance.downloadProfileImage(userID: profileUserID) { returnedImage in
            if let image = returnedImage {
                self.profileImage = image
            }
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
