//
//  PlayButton.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import SwiftUI

struct WhiteButton: View {
    var text: String
    var imageName: String
    var backgroundColor: Color = Color.white
    
    var action: () -> Void
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            HStack {
                Spacer()
                Image(systemName: imageName).font(.headline)
                Text(text).bold().font(.system(size: 16))
                Spacer()
                
            }
            .padding(.vertical, 6)
            .background(backgroundColor)
            .foregroundColor(backgroundColor == .white ? .black : .white)
            .cornerRadius(3.0)
        })
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            WhiteButton(text: "Play", imageName: "play.fill") {
                //
            }
        }
    }
}
