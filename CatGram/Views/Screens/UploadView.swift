//
//  UploadView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import UIKit
import SwiftUI
import PhotosUI

struct UploadView: View {
    
    @State private var showCameraPicker: Bool = false
    @State private var showPhotoPicker: Bool = false
    @State private var imageSelected: UIImage = UIImage(named: "logo")!
    @State  private var showPostImageView: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                //MARK: - CAMERA BUTTON
                Button {
                    showCameraPicker.toggle()
                } label: {
                    Text("Take photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.pinkColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.MyTheme.purpleColor)
                .sheet(isPresented: $showCameraPicker, onDismiss: segueToPostImageView) {
                    CameraPicker(imageSelected: $imageSelected)
                }
                
                //MARK: - PHOTO LIBRARY BUTTON
                Button {
                    showPhotoPicker.toggle()
                } label: {
                    Text("Import photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.purpleColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.MyTheme.pinkColor)
                .sheet(isPresented: $showPhotoPicker, onDismiss: segueToPostImageView) {
                    PhotoPicker(isPresented: $showPhotoPicker, imageSelected: $imageSelected)
                }
            }
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView) {
                    if showCameraPicker {
                        PostImageView(imageSelected: $imageSelected)
                    } else if showPhotoPicker {
//                        PostImageView(imageSelected: $showPhotoPicker)
                    }
                }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    //MARK: - FUNCTIONS
    
    func segueToPostImageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showPostImageView.toggle()
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
