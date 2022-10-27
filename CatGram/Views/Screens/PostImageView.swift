//
//  PostImageView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct PostImageView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var captionText: String = ""
    @Binding var imageSelected: UIImage
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
    //Alert
    @State var showAlert: Bool = false
    @State var postUploadedSuccessfully: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                }
                Spacer()
            }
            ScrollView {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                    .clipped()
                
                TextField(Localization.Screens.PostImageView.postImageViewPlaceholder, text: $captionText, axis: .horizontal)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.beigeColor)
                    .cornerRadius(12)
                    .font(.headline)
                    .padding(.horizontal)
                    .textInputAutocapitalization(.sentences)
                
                Button {
                    postPicture()
                } label: {
                    Text(Localization.Screens.PostImageView.postImageViewButton.uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.MyTheme.pinkColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
            .alert(getAlertTitle(), isPresented: $showAlert) {
                Button("OK") {
                    self.dismiss.callAsFunction()
                }
            } message: {
                Text(getAlertMessage())
            }
        }
    }
    
    //MARK: - FUNCTIONS
    
    func postPicture() {
        guard let userID = currentUserID, let displayName = currentUserDisplayName else {
            print("Error getting userID or displayName while posting image")
            return
        }
        
        DataService.instance.uploadPost(image: imageSelected, caption: captionText, displayName: displayName, userID: userID) { success in
            self.postUploadedSuccessfully = success
            self.showAlert.toggle()
        }
    }
    
    func getAlertTitle() -> LocalizedStringKey {
        if postUploadedSuccessfully {
            return "Post Success"
        } else {
            return "Post Failed"
        }
    }
    
    func getAlertMessage() -> String {
        if postUploadedSuccessfully {
            return Localization.Screens.PostImageView.postImageViewSuccessPostText
        } else {
            return Localization.Screens.PostImageView.postImageViewFailPostText
        }
    }
}

struct PostImageView_Previews: PreviewProvider {
    
    @State static var image = UIImage(named: "Cat1")!
    
    static var previews: some View {
        PostImageView(imageSelected: $image)
    }
}
