//
//  SettingsEditImageView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct SettingsEditImageView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var title: String
    @State var description: String
    @State var selectedImage: UIImage
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showImagePicker: Bool = false
    @Binding var profileImage: UIImage
    @State var showSuccessAlert: Bool = false
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
            
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipped()
                .cornerRadius(12)
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text(Localization.Screens.SettingsEditImageView.settingsEditImageButton.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.purpleColor)
                    .cornerRadius(12)
            }
            .foregroundColor(Color.MyTheme.pinkColor)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(imageSelected: $selectedImage, sourceType: $sourceType)
            }
            
            Button {
                saveImage()
            } label: {
                Text(Localization.Screens.SettingsEditTextView.settingsEditTextButton.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.pinkColor)
                    .cornerRadius(12)
            }

            
            Spacer()

        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationTitle(title)
        .alert("Saved", isPresented: $showSuccessAlert) {
            Button("OK") {
                self.dismiss.callAsFunction()
            }
        } message: {
            Text(Localization.Screens.SettingsEditTextView.settingsEditSuccess)
        }
    }
    
    //MARK: - FUNCTIONS
    
    func saveImage() {
        
        guard let userID = currentUserID else { return }
        
        // Update the UI of the profile
        profileImage = selectedImage
        
        // Update profile image in database
        ImageManager.instance.uploadProfileImage(userID: userID, image: selectedImage)
        
        showSuccessAlert.toggle()
    }
}

struct SettingsEditImageView_Previews: PreviewProvider {
    
    @State static var image: UIImage = UIImage(named: "Cat1")!
    
    static var previews: some View {
        NavigationView {
            SettingsEditImageView(title: "Title", description: "Description", selectedImage: UIImage(named: "Cat3")!, profileImage: $image)
        }
    }
}
