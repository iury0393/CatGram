//
//  FeedView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 14/10/22.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView {
            PostView()
            PostView()
            PostView()
            PostView()
        }
        .navigationTitle("FEED VIEW")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView()
            
        }
    }
}
