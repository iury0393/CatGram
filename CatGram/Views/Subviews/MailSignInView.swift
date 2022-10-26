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
                .autocapitalization(.sentences)
                .padding(.horizontal)
            
            Text(Localization.Screens.MailSignInView.passSignInTitle)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.MyTheme.pinkColor)
            
            TextField(Localization.Screens.MailSignInView.passSignInPlaceholder, text: $password)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)
            
            Button(action: {
                connectToFirebase()
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
    func connectToFirebase() {
        SignInWithMail.instance.startSignInCreateUser(email: email, password: password) { success in
            
        }
        
        SignInWithMail.instance.startSignInLogInUser(email: email, password: password) { success in
            
        }
    }
}

struct MailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        MailSignInView()
            .previewLayout(.sizeThatFits)
    }
}
