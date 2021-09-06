//
//  PlayButton.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import SwiftUI

struct WhiteButton: View {
    var body: some View {
        HStack {
            Image(systemName: "play")
            Text("Play").foregroundColor(.black)
            
        }.foregroundColor(.white)
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        WhiteButton()
    }
}
