//
//  Trailer.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-24.
//

import Foundation

struct Trailer: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var videoURL: URL
    var thumbnailURL: URL
}
