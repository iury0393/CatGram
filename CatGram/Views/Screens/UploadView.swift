//
//  UploadView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import UIKit
import SwiftUI
import PhotosUI

struct UploadView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showPostImageView: Bool = false
    @State var showSignUpView: Bool = false
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                Button {
                    if currentUserID != nil {
                        sourceType = UIImagePickerController.SourceType.camera
                        showImagePicker.toggle()
                    } else {
                        showSignUpView = true
                    }
                } label: {
                    Text(Localization.Screens.UploadView.uploadCamera.uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.pinkColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.MyTheme.purpleColor)
                
                Button {
                    if currentUserID != nil {
                        sourceType = UIImagePickerController.SourceType.photoLibrary
                        showImagePicker.toggle()
                    } else {
                        showSignUpView = true
                    }
                } label: {
                    Text(Localization.Screens.UploadView.uploadlibrary.uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.purpleColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.MyTheme.pinkColor)
            }
            .sheet(isPresented: $showImagePicker, onDismiss: segueToPostImageView) {
                ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
            }
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView) {
                    PostImageView(imageSelected: $imageSelected)
                }
        }
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $showSignUpView, onDismiss: {
            showSignUpView = false
            dismiss.callAsFunction()
        }) {
            SignUpView()
        }
    }
    
    //MARK: - FUNCTIONS
    
    func segueToPostImageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showPostImageView.toggle()
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
