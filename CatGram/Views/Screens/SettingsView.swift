//
//  SettingsView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismissView
    
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
                        Text("CatGram is the #1 app for posting pictures of your cat and sharing them across the world. We are a cat love community and we're happy to have you!")
                            .font(.footnote)
                    }
                } label: {
                    SettingsLabelView(labelText: "CatGram", labelImage: "dot.radiowaves.left.and.right")
                }
                .padding()
                
                //MARK: - SECTION 2 - PROFILE
                GroupBox {
                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current display name", title: "Display name", description: "You can edit your display name here. This will be seen by other users on your profile and on your posts!", placeholder: "Your display name here...")
                    } label: {
                        SettingsRowView(leftIcon: "pencil", text: "Display name", color: .MyTheme.purpleColor)
                    }
                    
                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current bio here", title: "Profile Bio", description: "Your bio is a great place to let othes users know a little about you. It will be shown on your profile only", placeholder: "Your bio here...")
                    } label: {
                        SettingsRowView(leftIcon: "text.quote", text: "Bio", color: .MyTheme.purpleColor)
                    }

                    
                    SettingsRowView(leftIcon: "photo", text: "Profile picture", color: .MyTheme.purpleColor)
                    SettingsRowView(leftIcon: "figure.walk", text: "Sign out", color: .MyTheme.purpleColor)
                } label: {
                    SettingsLabelView(labelText: "Profile", labelImage: "person.fill")
                }
                .padding()
                
                //MARK: - SECTION 3 - APPLICATION
                GroupBox {
                    SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: .MyTheme.pinkColor)
                    SettingsRowView(leftIcon: "folder.fill", text: "Terms & Coditions", color: .MyTheme.pinkColor)
                    SettingsRowView(leftIcon: "globe", text: "CatGram's Website", color: .MyTheme.pinkColor)
                } label: {
                    SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                }
                .padding()
                
                //MARK: - SECTION 4 - SIGN OFF
                GroupBox {
                    Text("CatGram was made with love. \nAll Rights Reserved \nIury Vasc. \nCopyright 2022 ❤️")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .padding(.bottom, 80)
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        dismissView.callAsFunction()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
