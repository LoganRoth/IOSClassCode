//
//  SmallVerticalButton.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import SwiftUI

struct SmallVerticalButton: View {
    var text: String
    var onImage: String
    var offImage: String
    var isOn: Bool
    
    
    
    var action: () -> Void
        
    var body: some View {
        Button(action: {
            action()
        }, label: {
            VStack {
                Image(systemName: isOn ? onImage : offImage).foregroundColor(.white)
                Text(text).foregroundColor(.white).font(.system(size: 14)).bold()
            }
        })
    }
}

struct SmallVerticalButton_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            SmallVerticalButton(text: "My List", onImage: "checkmark", offImage: "plus", isOn: false) {
                print("tapped")
            }
        }
    }
}
