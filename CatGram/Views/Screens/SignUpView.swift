//
//  SignUpView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 19/10/22.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showOnboardingPart2: Bool = false
    @State var showMailSignInView: Bool = false
    @State var showError: Bool = false
    
    @State var displayName: String = ""
    @State var email: String = ""
    @State var providerID: String = ""
    @State var provider: String = ""
        
    var body: some View {
        VStack(spacing: 10) {
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(radius: 12)
            
            Text(Localization.Screens.SignUpView.onboardingWelcome)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.MyTheme.purpleColor)
                .multilineTextAlignment(.center)
            
            Text(Localization.Screens.SettingsView.settingsAboutText)
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.MyTheme.purpleColor)
                .padding()
            
            //MARK: - SIGN IN WITH APPLE
            Button {
                SignInWithApple.instance.startSignInWithAppleFlow(view: self)
            } label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            }
            
            //MARK: - SIGN IN WITH MAIL
            Button {
                showMailSignInView.toggle()
            } label: {
                HStack {
                    Image(systemName: "envelope")
                        .font(.title3)

                    Text(Localization.Screens.SignUpView.onboardingButton)
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            }
            .background(Color(UIColor(red: 0.28, green: 0.33, blue: 0.38, alpha: 1.00)))
            .cornerRadius(6)
            .font(.system(size: 23, weight: .medium, design: .default))
            .foregroundColor(.white)
            .sheet(isPresented: $showMailSignInView, onDismiss: {
                dismiss.callAsFunction()
            }) {
                MailSignInView()
            }
        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.beigeColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.dismiss.callAsFunction()
        }) {
            OnboardingView(displayName: $displayName, email: $email, providerID: $providerID, provider: $provider)
        }
        .alert("Login failed.", isPresented: $showError) {
            Button("OK") {
                self.dismiss.callAsFunction()
            }
        } message: {
            Text(Localization.Screens.SignUpView.onboardingLogin)
        }
    }
    
    //MARK: - FUNCTIONS
    
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential) {
        AuthService.instance.logInUserToFirebase(credential: credential) { returnedProviderID, isError, isNewUser, returnedUserID  in
            if let newUser = isNewUser {
                if newUser {
                    // New User
                    if let providerID = returnedProviderID, !isError {
                        // New user continue to the onboarding part 2
                        self.displayName = name
                        self.email = email
                        self.providerID = providerID
                        self.provider = provider
                        
                        self.showOnboardingPart2.toggle()
                    } else {
                        // Error
                        print("Error getting providerID in user to Firebase")
                        self.showError.toggle()
                    }
                } else {
                    // Existing User
                    if let userID = returnedUserID {
                        // Success, Log in to app
                        AuthService.instance.logInUserToApp(userID: userID) { success in
                            if success {
                                print("Successfully logging existing user")
                                self.dismiss.callAsFunction()
                            } else {
                                print("Error logging existing user")
                                self.showError.toggle()
                            }
                        }
                    } else {
                        // Error
                        print("Error getting USERID from existing user to Firebase")
                        self.showError.toggle()
                    }
                }
            } else {
                // Error
                print("Error from log in user to Firebase")
                self.showError.toggle()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
