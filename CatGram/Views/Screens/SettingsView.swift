//
//  SettingsView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var showSignOutError: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                //MARK: - SECTION 1 - CATGRAM
                GroupBox {
                    HStack(spacing: 10) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .cornerRadius(12)
                        Text(Localization.Screens.SettingsView.settingsAboutText)
                            .font(.footnote)
                    }
                } label: {
                    SettingsLabelView(labelText: "CatGram", labelImage: "dot.radiowaves.left.and.right")
                }
                .padding()
                
                //MARK: - SECTION 2 - PROFILE
                GroupBox {
                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current display name", title: Localization.Screens.SettingsView.settingsProfileEditName, description: Localization.Screens.SettingsView.settingsProfileEditDescription, placeholder: Localization.Screens.SettingsView.settingsProfileEditPlaceholder)
                    } label: {
                        SettingsRowView(leftIcon: "pencil", text: Localization.Screens.SettingsView.settingsProfileEditName, color: .MyTheme.purpleColor)
                    }
                    
                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current bio here", title: Localization.Screens.SettingsView.settingsBioEditName, description: Localization.Screens.SettingsView.settingsBioEditDescription, placeholder: Localization.Screens.SettingsView.settingsBioEditPlaceholder)
                    } label: {
                        SettingsRowView(leftIcon: "text.quote", text: Localization.Screens.SettingsView.settingsBioEditName2, color: .MyTheme.purpleColor)
                    }
                    
                    NavigationLink {
                        SettingsEditImageView(title: Localization.Screens.SettingsView.settingsImageEditName, description: Localization.Screens.SettingsView.settingsImageEditDescription, selectedImage: UIImage(named: "Cat3")!)
                    } label: {
                        SettingsRowView(leftIcon: "photo", text: Localization.Screens.SettingsView.settingsImageEditName, color: .MyTheme.purpleColor)
                    }
                    
                    Button {
                        signOut()
                    } label: {
                        SettingsRowView(leftIcon: "figure.walk", text: Localization.Screens.SettingsView.settingsSignOut, color: .MyTheme.purpleColor)
                    }
                    .alert("Error Sign Out.", isPresented: $showSignOutError) {
                        Button("OK") {
                            self.dismiss.callAsFunction()
                        }
                    } message: {
                        Text(Localization.Screens.SettingsView.settingsSignOut2)
                    }

                } label: {
                    SettingsLabelView(labelText: Localization.Screens.ContentView.profileBar, labelImage: "person.fill")
                }
                .padding()
                
                //MARK: - SECTION 3 - APPLICATION
                GroupBox {
                    
                    Button {
                        openCustomURL(urlString: "https://www.google.com")
                    } label: {
                        SettingsRowView(leftIcon: "folder.fill", text: Localization.Screens.SettingsView.settingsPrivacy, color: .MyTheme.pinkColor)
                    }
                    Button {
                        openCustomURL(urlString: "https://www.google.com")
                    } label: {
                        SettingsRowView(leftIcon: "folder.fill", text: Localization.Screens.SettingsView.settingsTerms, color: .MyTheme.pinkColor)
                    }
                    
                    Button {
                        openCustomURL(urlString: "https://www.linkedin.com/in/iury-vasconcelos-dev/")
                    } label: {
                        SettingsRowView(leftIcon: "globe", text: Localization.Screens.SettingsView.settingsSite, color: .MyTheme.pinkColor)
                    }
                    
                    
                    
                } label: {
                    SettingsLabelView(labelText: Localization.Screens.SettingsView.settingsApplication, labelImage: "apps.iphone")
                }
                .padding()
                
                //MARK: - SECTION 4 - SIGN OFF
                GroupBox {
                    Text(Localization.Screens.SettingsView.settingsSignOff)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .padding(.bottom, 80)
                
            }
            .navigationTitle(Localization.Screens.SettingsView.settingsBar)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                    }
                }
            }
        }
    }
    
    //MARK: - FUNCTIONS
    
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
    }
    
    func signOut() {
        AuthService.instance.logOutUser { success in
            if success {
                print("Successfully logged out")
                // Dismiss settings view
                self.dismiss.callAsFunction()
            } else {
                print("Error logging out")
                self.showSignOutError.toggle()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
