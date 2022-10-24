//
//  OnboardingView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 19/10/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showOnboardingPart2: Bool = false
    @State var showError: Bool = false
    
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
            
            //MARK: - SIGN IN WITH GOOGLE
            Button {
                showOnboardingPart2.toggle()
            } label: {
                HStack {
                    Image("google-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text(Localization.Screens.OnboardingView.onboardingButton)
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            }
            .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255))
            .cornerRadius(6)
            .font(.system(size: 23, weight: .medium, design: .default))
            .foregroundColor(.white)
            
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
        .fullScreenCover(isPresented: $showOnboardingPart2) {
            OnboardingViewPart2()
        }
        .alert( "Login failed.", isPresented: $showError) {
            Button("OK") {
                // Handle the acknowledgement.
            }
        } message: {
            Text(Localization.Screens.OnboardingView.onboardingLogin)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
