//
//  MailSignInView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 26/10/22.
//

import SwiftUI

struct MailSignInView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showOnboardingPart2: Bool = false
    @State var showError: Bool = false
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var displayName: String = ""
    @State var providerID: String = ""
    @State var provider: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(Localization.Screens.MailSignInView.mailSignInTitle)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.MyTheme.pinkColor)
            
            TextField(Localization.Screens.MailSignInView.mailSignInPlaceholder, text: $email)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.none)
                .padding(.horizontal)
            
            Text(Localization.Screens.MailSignInView.passSignInTitle)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.MyTheme.pinkColor)
            
            SecureField(Localization.Screens.MailSignInView.passSignInPlaceholder, text: $password)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.none)
                .padding(.horizontal)
            
            Button(action: {
                SignInWithMail.instance.startSignInWithEmailFlow(view: self)
            }, label: {
                Text(Localization.Screens.MailSignInView.mailSignInButton)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.pinkColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.purpleColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.dismiss.callAsFunction()
        }) {
            OnboardingView(displayName: $displayName, email: $email, providerID: $providerID, provider: $provider)
        }
        .alert( "Login failed.", isPresented: $showError) {
            Button("OK") {
                self.dismiss.callAsFunction()
            }
        } message: {
            Text(Localization.Screens.SignUpView.onboardingLogin)
        }
    }
    
    //MARK: - FUNCTIONS
    func connectToFirebase() {
        AuthService.instance.logInUserWithEmail(email: email) { isNew, returnedUserID in
            if isNew {
                // New User
                SignInWithMail.instance.startSignInCreateUser(email: email, password: password) { success, returnedProviderID in
                    if success {
                        if let providerID = returnedProviderID {
                            // New user continue to the onboarding part 2
                            self.displayName = ""
                            self.email = email
                            self.providerID = providerID
                            self.provider = "mail"
                            
                            self.showOnboardingPart2.toggle()
                        } else {
                            // Error
                            print("Error getting providerID in user to Firebase")
                            self.showError.toggle()
                        }
                    } else {
                        // Error
                        print("Error creating user to Firebase")
                        self.showError.toggle()
                    }
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
        }
    }
}

struct MailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        MailSignInView()
            .previewLayout(.sizeThatFits)
    }
}
