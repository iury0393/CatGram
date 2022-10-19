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
    
    var body: some View {
        VStack(spacing: 10) {
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(radius: 12)
            
            Text("Welcome to CatGram!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.MyTheme.purpleColor)
            
            Text(Localization.Screens.SettingsView.settingsAboutText)
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.MyTheme.purpleColor)
                .padding()
            
            Button {
                showOnboardingPart2.toggle()
            } label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            }
            
            Button {
                showOnboardingPart2.toggle()
            } label: {
                HStack {
                    Image("google-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("Sign in With Google")
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
                Text("Continue as guest".uppercased())
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
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
