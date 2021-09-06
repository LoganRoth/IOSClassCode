//
//  HomeVM.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import Foundation

class HomeVM: ObservableObject {
    @Published var movies: [String: [Movie]] = [:]
    
    public var allCategories: [String] {
        return movies.keys.map({ String($0) })
    }
    
    public func getMovie(forCat cat: String, andHomeRow homeRow: HomeTopRow) -> [Movie] {
        
        switch homeRow {
        case .home:
            return movies[cat] ?? []
        case .tvShows:
            return (movies[cat] ?? []).filter({ $0.movieType == .tvShow })
        case .movies:
            return (movies[cat] ?? []).filter({ $0.movieType == .movie })
        case .myList:
            return movies[cat] ?? []
        }
    }
    
    init() {
        setupMovies()
    }
    
    func setupMovies() {
        movies["Trending Now"] = exampleMovies
        movies["Comedy"] = exampleMovies.shuffled()
        movies["Watch It Again"] = exampleMovies.shuffled()
        movies["Sexy"] = exampleMovies.shuffled()
        movies["Action"] = exampleMovies.shuffled()
        movies["Scary"] = exampleMovies.shuffled()
        movies["Crime"] = exampleMovies.shuffled()
    }
}
