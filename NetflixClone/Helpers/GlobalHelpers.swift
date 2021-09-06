//
//  GlobalHelpers.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import Foundation
import SwiftUI

let exampleVideoURL = URL(string: "https://www.radiantmediaplayer.com/media/big-buck-bunny-360p.mp4")!

let exampleImageURL = URL(string: "https://picsum.photos/300/100")!
let exampleImageURL2 = URL(string: "https://picsum.photos/301/100")!
let exampleImageURL3 = URL(string: "https://picsum.photos/300/101")!
let exampleImageURL4 = URL(string: "https://picsum.photos/301/101")!

var randomExampleImageURL: URL {
    return [exampleImageURL, exampleImageURL2, exampleImageURL3, exampleImageURL4].randomElement() ?? exampleImageURL
}

let exampleTrailer1 = Trailer(name: "Season 3 Trailer", videoURL: exampleVideoURL, thumbnailURL: randomExampleImageURL)
let exampleTrailer2 = Trailer(name: "The Journey", videoURL: exampleVideoURL, thumbnailURL: randomExampleImageURL)
let exampleTrailer3 = Trailer(name: "Sup Sup", videoURL: exampleVideoURL, thumbnailURL: randomExampleImageURL)

let exampleTrailers = [exampleTrailer1, exampleTrailer2, exampleTrailer3]

let exampleMovie1 = Movie(
    name: "DARK",
    thumbnailURL: URL(string: "https://picsum.photos/200/300")!,
    categories: ["Scary", "Dark", "Dystopian"],
    year: 2020,
    rating: "TV-MA",
    numSeasons: 5,
    defaultEpisodeInfo: exEpDesc,
    creators: "Guy",
    cast: "Other Guy",
    moreLikeThisMovies: [exampleMovie2, exampleMovie3, exampleMovie4, exampleMovie5, exampleMovie6, exampleMovie7],
    episodes: allEpisodes,
    promoHeadline: "Watch Season 5 Now",
    trailers: exampleTrailers
)


let exampleMovie2 = Movie(
    name: "Travelers",
    thumbnailURL: URL(string: "https://picsum.photos/200/301")!,
    categories: ["Exciting", "Sci-Fi", "Fun"],
    year: 2020,
    rating: "TV-MA",
    defaultEpisodeInfo: exEpDesc,
    creators: "Guy",
    cast: "Other Guy",
    moreLikeThisMovies: [],
    promoHeadline: "Top Rated Movie",
    trailers: exampleTrailers
)


let exampleMovie3 = Movie(
    name: "Lucifer",
    thumbnailURL: URL(string: "https://picsum.photos/200/302")!,
    categories: ["Funny", "Scary", "Crime"],
    year: 2020,
    rating: "TV-MA",
    numSeasons: 2,
    defaultEpisodeInfo: exEpDesc,
    creators: "Guy",
    cast: "Other Guy",
    moreLikeThisMovies: [],
    episodes: allEpisodes,
    trailers: exampleTrailers
)


let exampleMovie4 = Movie(
    name: "Community",
    thumbnailURL: URL(string: "https://picsum.photos/201/300")!,
    categories: ["Funny", "Comedy", "College"],
    year: 2020,
    rating: "TV-MA",
    numSeasons: 3,
    defaultEpisodeInfo: exEpDesc,
    creators: "Guy",
    cast: "Other Guy",
    moreLikeThisMovies: [],
    episodes: allEpisodes,
    promoHeadline: "New Episodes",
    trailers: exampleTrailers
)


let exampleMovie5 = Movie(
    name: "Hannibal",
    thumbnailURL: URL(string: "https://picsum.photos/202/300")!,
    categories: ["Crime", "Scary", "Horror"],
    year: 2020,
    rating: "TV-MA",
    numSeasons: 4,
    defaultEpisodeInfo: exEpDesc,
    creators: "Guy",
    cast: "Other Guy",
    moreLikeThisMovies: [],
    episodes: allEpisodes,
    trailers: exampleTrailers
)


let exampleMovie6 = Movie(
    name: "Afterlife",
    thumbnailURL: URL(string: "https://picsum.photos/201/301")!,
    categories: ["Sci-Fi", "Exciting", "Action"],
    year: 2020,
    rating: "TV-MA",
    defaultEpisodeInfo: exEpDesc,
    creators: "Guy",
    cast: "Other Guy",
    moreLikeThisMovies: [],
    trailers: exampleTrailers
)

let exampleMovie7 = Movie(
    name: "ThingThing",
    thumbnailURL: URL(string: "https://picsum.photos/201/302")!,
    categories: ["Sci-Fi", "Exciting", "Action"],
    year: 2020,
    rating: "TV-MA",
    defaultEpisodeInfo: exEpDesc,
    creators: "Guy",
    cast: "Other Guy",
    moreLikeThisMovies: [],
    trailers: exampleTrailers
)


var exampleMovies: [Movie] {
    return [exampleMovie1, exampleMovie2, exampleMovie3, exampleMovie4, exampleMovie5, exampleMovie6].shuffled()
}

let exEpDesc = CurrentEpisodeInfo(epName: "Example Name", description: "Example description", season: 1, episode: 1)

extension LinearGradient {
    static let blackOpacityGradient = LinearGradient(
        gradient:
            Gradient(
                colors: [Color.black.opacity(0), Color.black.opacity(0.95)]),
        startPoint: .top,
        endPoint: .bottom)
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttr = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttr)
        return size.width
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


let episode1 = Episode(
    name: "Big Boy",
    season: 1,
    episodeNumber: 1,
    thumbnailImgURLString: "https://picsum.photos/300/100",
    description: "This is one big boy",
    length: 53,
    videoURL: exampleVideoURL
)

let episode2 = Episode(
    name: "Yeet",
    season: 1,
    episodeNumber: 2,
    thumbnailImgURLString: "https://picsum.photos/301/100",
    description: "THROW THE FUCKIN THING",
    length: 54,
    videoURL: exampleVideoURL
)

let episode3 = Episode(
    name: "Sup Yo",
    season: 1,
    episodeNumber: 2,
    thumbnailImgURLString: "https://picsum.photos/300/101",
    description: "Good afternoon good sir",
    length: 56,
    videoURL: exampleVideoURL
)


let episode4 = Episode(
    name: "Big Boy",
    season: 2,
    episodeNumber: 1,
    thumbnailImgURLString: "https://picsum.photos/303/103",
    description: "This is one big boy",
    length: 53,
    videoURL: exampleVideoURL
)

let episode5 = Episode(
    name: "Yeet",
    season: 2,
    episodeNumber: 2,
    thumbnailImgURLString: "https://picsum.photos/301/105",
    description: "THROW THE FUCKIN THING",
    length: 54,
    videoURL: exampleVideoURL
)

let episode6 = Episode(
    name: "Sup Yo",
    season: 2,
    episodeNumber: 2,
    thumbnailImgURLString: "https://picsum.photos/303/101",
    description: "Good afternoon good sir",
    length: 56,
    videoURL: exampleVideoURL
)

var allEpisodes = [episode1, episode2, episode3, episode4, episode5, episode6]
