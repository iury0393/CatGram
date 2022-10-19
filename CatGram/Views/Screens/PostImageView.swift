//
//  PostImageView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct PostImageView: View {
    
    @Environment(\.dismiss) private var dismissView
    @State private var captionText: String = ""
    @Binding var imageSelected: UIImage
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismissView.callAsFunction()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                }
                Spacer()
            }
            ScrollView {
                Image("Cat1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                    .clipped()
                
                TextField(Localization.Screens.PostImageView.postImageViewPlaceholder, text: $captionText, axis: .horizontal)
                    .padding()
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.beigeColor)
                    .cornerRadius(12)
                    .font(.headline)
                    .padding(.horizontal)
                    .textInputAutocapitalization(.sentences)
                
                Button {
                    postPicture()
                } label: {
                    Text(Localization.Screens.PostImageView.postImageViewButton.uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.MyTheme.pinkColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
        }
    }
    
    //MARK: - FUNCTIONS
    
    func postPicture() {
        
    }
}

struct PostImageView_Previews: PreviewProvider {
    
    @State static var image = UIImage(named: "Cat1")!
    
    static var previews: some View {
        PostImageView(imageSelected: $image)
    }
}
