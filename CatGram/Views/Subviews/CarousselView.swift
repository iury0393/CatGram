//
//  CarousselView.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 17/10/22.
//

import SwiftUI

struct CarousselView: View {
    
    @State var selection: Int = 1
    let maxCount: Int = 8
    @State var timerAdded: Bool = false
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(1..<maxCount, id: \.self) { count in
                Image("Cat\(count)")
                    .resizable()
                    .scaledToFill()
                    .tag(count)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 300)
        .animation(.default, value: selection)
        .onAppear{
            if !timerAdded {
                addTimer()
            }
        }
    }
    
    //MARK: - FUNCTIONS
    
    func addTimer() {
        timerAdded = true
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            if selection == (maxCount - 1) {
                selection = 1
            } else {
                selection += 1
            }
        }
        timer.fire()
    }
}

struct CarousselView_Previews: PreviewProvider {
    static var previews: some View {
        CarousselView()
            .previewLayout(.sizeThatFits)
    }
}
