//
//  UnlikeAnimationView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 02/11/22.
//

import SwiftUI

struct UnlikeAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red.opacity(0.3))
                    .font(.system(size: 200))
                    .opacity(animate ? 1.0 : 0.0)
                    .scaleEffect(animate ? 0.3 : 1.0)
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.red.opacity(0.6))
                    .font(.system(size: 150))
                    .opacity(animate ? 1.0 : 0.0)
                    .scaleEffect(animate ? 0.4 : 1.0)
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.red.opacity(0.9))
                    .font(.system(size: 100))
                    .opacity(animate ? 1.0 : 0.0)
                    .scaleEffect(animate ? 0.5 : 1.0)
            }
            .animation(Animation.easeOut(duration: 0.5), value: animate)
        }    }
}

struct UnlikeAnimationView_Previews: PreviewProvider {
    
    @State static var animate: Bool = false
    
    static var previews: some View {
        UnlikeAnimationView(animate: $animate)
            .previewLayout(.sizeThatFits)
    }
}
