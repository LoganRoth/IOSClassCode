//
//  Movie.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import Foundation

struct Movie: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var thumbnailURL: URL
        
    var categories: [String]
    
    // MovieDetailView
    var year: Int
    var rating: String
    var numSeasons: Int?
    
    // Personalization
    var currentEpisode: CurrentEpisodeInfo?
    
    var defaultEpisodeInfo: CurrentEpisodeInfo
    var creators: String
    var cast: String
    
    var moreLikeThisMovies: [Movie]
    
    var episodes: [Episode]?
    
    var movieType: MovieType {
        return episodes == nil ? .movie : .tvShow
    }
    
    var promoHeadline: String?
    
    var trailers: [Trailer]
    
    var numSeasonsDisplay: String {
        if let num = numSeasons {
            if num == 1 {
                return "1 Season"
            } else {
                return "\(num) Seasons"
            }
        }
        return ""
    }
    
    var episodeInfoDisplay: String {
        if let current = currentEpisode {
            return "S\(current.season):E\(current.episode) \(current.epName)"
        } else {
            return ""
        }
    }
    
    var episodeDescDisplay: String {
        if let current = currentEpisode {
            return current.description
        } else {
            return defaultEpisodeInfo.description
        }
        
    }
}


struct CurrentEpisodeInfo: Hashable, Equatable {
    var epName: String
    var description: String
    var season: Int
    var episode: Int
    
}

enum MovieType {
    case movie
    case tvShow
}
