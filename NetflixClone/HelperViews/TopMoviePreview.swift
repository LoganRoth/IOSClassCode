//
//  TopMoviePreview.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import SwiftUI
import KingfisherSwiftUI

struct TopMoviePreview: View {
    var movie: Movie
    
    let screen = UIScreen.main.bounds
    
    func isLastCategory(_ cat: String) -> Bool {
        let catCount = movie.categories.count
        if let idx = movie.categories.firstIndex(of: cat) {
            if idx + 1 != catCount {
                return false
            }
        }
        
        return true
    }
    
    var body: some View {
        ZStack {
            KFImage(movie.thumbnailURL).resizable().scaledToFill().clipped()
            
            VStack {
                Spacer()
                HStack {
                    ForEach(movie.categories, id: \.self) { category in
                        HStack {
                            Text(category).font(.footnote)
                            
                            if !isLastCategory(category) {
                                Image(systemName: "circle.fill").foregroundColor(.blue).font(.system(size: 3))
                            }
                        }
                    }
                }.padding(.bottom, 5)
                HStack {
                    Spacer()
                    SmallVerticalButton(text: "My List", onImage: "checkmark", offImage: "plus", isOn: false) {
                        //
                    }
                    Spacer()
                    
                    WhiteButton(text: "Play", imageName: "play.fill") {
                        //
                    }.frame(width: screen.width * 0.3)
                    
                    Spacer()
                    SmallVerticalButton(text: "Info", onImage: "info.circle", offImage: "info.circle", isOn: true) {
                        //
                    }
                    Spacer()
                }
            }.background(
                LinearGradient.blackOpacityGradient
                .padding(.top, 250))
        }.foregroundColor(.white)
    }
}

struct TopMoviePreview_Previews: PreviewProvider {
    static var previews: some View {
        TopMoviePreview(movie: exampleMovie1)
    }
}
