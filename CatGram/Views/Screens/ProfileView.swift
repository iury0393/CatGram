//
//  ProfileView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView{
            ProfileHeaderView()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "line.horizontal.3")
            }

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
