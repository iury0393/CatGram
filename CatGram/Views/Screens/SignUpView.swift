//
//  SignUpView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 19/10/22.
//

import SwiftUI

struct SignUpView: View {
    
    @State var showOnboarding: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(Localization.Screens.SignUpView.signUpInfo)
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Text(Localization.Screens.SignUpView.signUpText)
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Button {
                showOnboarding.toggle()
            } label: {
                Text(Localization.Screens.SignUpView.signUpButton.uppercased())
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.MyTheme.purpleColor)
                    .foregroundColor(.MyTheme.pinkColor)
                    .cornerRadius(12)
                    .shadow(radius: 12)
            }
            
            Spacer()
            Spacer()
        }
        .padding(.all, 3)
        .background(Color.MyTheme.pinkColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
