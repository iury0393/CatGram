//
//  SettingsEditTextView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct SettingsEditTextView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
    @State var settingsEditTextOption: SettingsEditTextOption
    @Binding var profileText: String
    @State var showSuccessAlert: Bool = false
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    var body: some View {
        VStack {
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
                    
            TextField(placeholder, text: $submissionText, axis: .horizontal)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .textInputAutocapitalization(.sentences)
            
            Button {
                if textIsAppropriate() {
                    saveText()
                }
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
    
    func textIsAppropriate() -> Bool {
        // Check if the text has curses
        // Check if the text is long enough
        // Check if the text is blank
        // Check for innapropriate things
        let badWordArray: [String] = ["shit", "ass"]
        
        let words = submissionText.components(separatedBy: " ")
        
        for word in words {
            if badWordArray.contains(word) {
                return false
            }
        }
        
        if submissionText.count < 3 {
            return false
        }
        
        return true
    }
    
    func saveText() {
        
        guard let userID = currentUserID else { return }
        
        switch settingsEditTextOption {
        case .displayName:
            
            // Update the UI on the profile
            profileText = submissionText
            
            // Update the UserDefaults
            UserDefaults.standard.set(submissionText, forKey: CurrentUserDefaults.displayName)
            
            // Update on all of the user's posts
            DataService.instance.updateDisplayNameOnPosts(userID: userID, displayName: submissionText)
            
            // Update on the user's profile in DB
            AuthService.instance.updateUserDisplayName(userID: userID, displayName: submissionText) { success in
                if success {
                    showSuccessAlert.toggle()
                }
            }
            
        case .bio:
            
            // Update the UI on the profile
            profileText = submissionText
            
            // Update the UserDefaults
            UserDefaults.standard.set(submissionText, forKey: CurrentUserDefaults.bio)
            
            // Update on the user's profile in DB
            AuthService.instance.updateUserBio(userID: userID, bio: submissionText) { success in
                if success {
                    showSuccessAlert.toggle()
                }
            }
        }
        
    }
}

struct SettingsEditTextView_Previews: PreviewProvider {
    
    @State static var text: String = ""
    
    static var previews: some View {
        NavigationView {
            SettingsEditTextView(title: "Test title", description: "This is a description", placeholder: "Test Placeholder", settingsEditTextOption: .displayName, profileText: $text)
        }
    }
}
