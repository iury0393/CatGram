//
//  ProfileHeaderView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @Binding var profileDisplayName: String
    @Binding var profileImage: UIImage
    @Binding var profileBio: String
    @ObservedObject var postArray: PostArrayObject
    
    var body: some View {
        VStack(spacing: 10) {
            
            //MARK: - PROFILE PICTURE
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .cornerRadius(60)
            
            //MARK: - USER NAME
            Text(profileDisplayName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            //MARK: - BIO
            if profileBio != "" {
                Text(profileBio)
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 20) {
                //MARK: - POSTS
                VStack(spacing: 5) {
                    Text("\(postArray.postCountString)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2)
                    
                    Text("Post")
                        .font(.callout)
                        .fontWeight(.medium)
                }
                
                //MARK: - LIKES
                VStack(spacing: 5) {
                    Text("\(postArray.likeCountString)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2)
                    
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    
    @State static var name: String = "Joe"
    @State static var bio: String = ""
    @State static var profileImage: UIImage = UIImage(named: "Cat1")!
    
    static var previews: some View {
        ProfileHeaderView(profileDisplayName: $name, profileImage: $profileImage, profileBio: $bio, postArray: PostArrayObject(shuffled: false))
            .previewLayout(.sizeThatFits)
    }
}
