//
//  TrailerList.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-24.
//

import SwiftUI

struct TrailerList: View {
    
    var trailers: [Trailer]
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        VStack {
            ForEach(trailers) { trailer in
                VStack {
                    VideoPreviewImage(imageURL: trailer.thumbnailURL, videoURL: trailer.videoURL)
                    Text(trailer.name).frame(maxWidth: screen.width)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 10)
        }
    }
}

struct TrailerList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            TrailerList(trailers: exampleTrailers)
        }
    }
}
