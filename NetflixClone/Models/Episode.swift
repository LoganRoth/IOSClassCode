//
//  Episode.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-21.
//

import Foundation

struct Episode: Identifiable {
    var id = UUID().uuidString
    
    var name: String
    var season: Int
    var episodeNumber: Int
    var thumbnailImgURLString: String
    var description: String
    var length: Int
    
    var videoURL: URL
    
    var thumbnail: URL {
        return URL(string: thumbnailImgURLString)!
    }
}
