//
//  OnboardingViewPart2.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 19/10/22.
//

import SwiftUI

struct OnboardingViewPart2: View {
    
    @Binding var displayName: String
    @Binding var email: String
    @Binding var providerID: String
    @Binding var provider: String
    
    @State var showImagePicker: Bool = false
    @State private var isAnimating: Bool = false
    
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack(alignment: .center, spacing: 20, content: {
            
            Text(Localization.Screens.OnboardingViewPart2.onboardingPart2Title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.MyTheme.pinkColor)
            
            TextField(Localization.Screens.OnboardingViewPart2.onboardingPart2Placeholder, text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)
                .onChange(of: displayName) { newValue in
                    if newValue != "" {
                        isAnimating = true
                    } else {
                        isAnimating = false
                    }
                }
            
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                Text(Localization.Screens.OnboardingViewPart2.onboardingPart2Button)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.pinkColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
            })
            .opacity(isAnimating ? 1.0 : 0.0)
            .animation(.easeOut(duration: 0.5), value: isAnimating)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.purpleColor)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker, onDismiss: createProfile, content: {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
        })
        
    }
    
    // MARK: FUNCTIONS
    
    func createProfile() {
        
    }
}

struct OnboardingViewPart2_Previews: PreviewProvider {
    
    @State static var testString = "test"
    
    static var previews: some View {
        OnboardingViewPart2(displayName: $testString, email: $testString, providerID: $testString, provider: $testString)
    }
}
