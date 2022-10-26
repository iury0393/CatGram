//
//  OnboardingView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 19/10/22.
//

import SwiftUI
import FirebaseAuth

struct OnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showOnboardingPart2: Bool = false
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
            
            Text(Localization.Screens.OnboardingView.onboardingWelcome)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.MyTheme.purpleColor)
            
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
            
            //MARK: - SIGN IN WITH ANOTHER SERVICE LATER
//            Button {
//                showOnboardingPart2.toggle()
//            } label: {}
            
            Button {
                dismiss.callAsFunction()
            } label: {
                Text(Localization.Screens.OnboardingView.onboardingGuest.uppercased())
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
                    .foregroundColor(.black)
            }


        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.beigeColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.dismiss.callAsFunction()
        }) {
            OnboardingViewPart2(displayName: $displayName, email: $email, providerID: $providerID, provider: $provider)
        }
        .alert( "Login failed.", isPresented: $showError) {
            Button("OK") {
                // Handle the acknowledgement.
            }
        } message: {
            Text(Localization.Screens.OnboardingView.onboardingLogin)
        }
    }
    
    //MARK: - FUNCTIONS
    
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential) {
        AuthService.instance.logInUserToFirebase(credential: credential) { returnedProviderID, isError in
            if let providerID = returnedProviderID, !isError {
                
                self.displayName = name
                self.email = email
                self.providerID = providerID
                self.provider = provider
                
                self.showOnboardingPart2.toggle()
            } else {
                print("Error from log in user to Firebase")
                self.showError.toggle()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
