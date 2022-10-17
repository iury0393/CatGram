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
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    
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
                .sheet(isPresented: $showCameraPicker) {
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
                .sheet(isPresented: $showPhotoPicker) {
                    let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                    PhotoPicker(configuration: configuration, isPresented: $showPhotoPicker)
                }
            }
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(radius: 12)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
