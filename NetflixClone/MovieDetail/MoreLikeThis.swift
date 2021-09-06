//
//  MoreLikeThis.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-23.
//

import SwiftUI

struct MoreLikeThis: View {
    
    var movies: [Movie]
    
    let cols = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: cols) {
            ForEach(0..<movies.count) { index in
                StandardHomeMovie(movie: movies[index])
            }
        }
    }
}

struct MoreLikeThis_Previews: PreviewProvider {
    static var previews: some View {
        MoreLikeThis(movies: exampleMovies)
    }
}
