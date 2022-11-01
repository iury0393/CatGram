//
//  CarousselView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import SwiftUI

struct CarousselView: View {
    
    @State var selection: Int = 0
    @State var timerAdded: Bool = false
    @ObservedObject var posts: PostArrayObject
    @State var postImages: [UIImage] = [UIImage]()
    @State var postImage: UIImage = UIImage(named: "logo.loading")!
    @State var testImage: UIImage = UIImage(named: "logo.loading")!
    
    var body: some View {
        TabView(selection: $selection) {
            Image(uiImage: postImages.count > 1 ? postImage : testImage)
                .resizable()
                .scaledToFill()
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 300)
        .animation(.default, value: selection)
        .onAppear{
            getImagePost()
            if !timerAdded {
                addTimer()
            }
        }
    }
    
    //MARK: - FUNCTIONS
    
    func addTimer() {
        timerAdded = true
        let timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { timer in
            if selection == (postImages.count - 1) {
                selection = 0
                postImage = postImages[selection]
            } else {
                selection += 1
                postImage = postImages[selection]
            }
        }
        timer.fire()
    }
    
    func getImagePost() {
        for post in posts.dataArray {
            ImageManager.instance.downloadPostImage(postID: post.postID) { returnedImage in
                if let image = returnedImage {
                    postImages.append(image)
                } else {
                    print("Error downloading images")
                }
            }
        }
    }
}

struct CarousselView_Previews: PreviewProvider {
    static var previews: some View {
        CarousselView(posts: PostArrayObject(shuffled: false))
            .previewLayout(.sizeThatFits)
    }
}
