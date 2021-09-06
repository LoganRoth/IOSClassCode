//
//  MovieDetail.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-21.
//

import SwiftUI

struct MovieDetail: View {
    var movie: Movie
    
    let screen = UIScreen.main.bounds
    
    @State private var showSeasonPicker = false
    @State private var selSeason = 1
    
    @Binding var movieDetailToShow: Movie?
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Close View
                            movieDetailToShow = nil
                        }, label: {
                                Image(systemName: "xmark.circle")
                        })
                    }.padding(.horizontal, 22)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            StandardHomeMovie(movie: movie).frame(width: screen.width * 0.4)
                        
                            MovieInfoSubHeadline(movie: movie)
                            
                            if movie.promoHeadline != nil {
                                Text(movie.promoHeadline!)
                                    .bold()
                                    .font(.headline)
                            }
                            
                            WhiteButton(text: "Play", imageName: "play.fill", backgroundColor: Color.red) {
                                //
                            }
                            
                            // Current Episode Info
                            CurrentEpisodeInformationDisplay(movie: movie)
                            
                            CastInfo(movie: movie)
                            
                            HStack(spacing: 60) {
                                SmallVerticalButton(text: "My List", onImage: "checkmark", offImage: "plus", isOn: false) {
                                    //
                                }
                                SmallVerticalButton(text: "Rate", onImage: "hand.thumbsup.fill", offImage: "hand.thumbsup", isOn: false) {
                                    //
                                }
                                SmallVerticalButton(text: "Share", onImage: "square.and.arrow.up", offImage: "square.and.arrow.up", isOn: false) {
                                    //
                                }
                                Spacer()
                            }.padding(.leading, 20)
                            
                            CustomTabSwitcher(tabs: [.episodes, .trailers, .more], movie: movie, showSeasonPicker: $showSeasonPicker, selSeason: $selSeason)
                            
                        }.padding(.horizontal, 10)
                        
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                
                if showSeasonPicker {
                    Group {
                        Color.black.opacity(0.90)
                        VStack(spacing: 40) {
                            Spacer()
                            ForEach(0..<(movie.numSeasons ?? 0)) { season in
                                Button(action: {
                                    self.selSeason = season + 1
                                    self.showSeasonPicker = false
                                }, label: {
                                    Text("Season \(season + 1)")
                                        .bold()
                                        .font(selSeason == season + 1 ? .title : .title2)
                                }).foregroundColor(selSeason == season + 1 ? .white : .gray)
                            }
                            Spacer()
                            Button(action: {
                                self.showSeasonPicker = false
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                                    .scaleEffect(x: 1.1)
                            }).padding(.bottom, 30)
                        }
                    }.edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: exampleMovie1, movieDetailToShow: .constant(nil))
    }
}

struct MovieInfoSubHeadline: View {
    var movie: Movie
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "hand.thumbsup.fill").foregroundColor(.white)
            Text(String(movie.year))
            RatingSubView(rating: movie.rating)
            Text(String(movie.numSeasonsDisplay))
        }
        .foregroundColor(.gray)
        .padding(.vertical, 6)
    }
}

struct RatingSubView: View {
    var rating: String
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.gray)
            Text(rating).foregroundColor(.white).font(.system(size: 12)).bold()
        }.frame(width: 50, height: 20)
    }
}

struct CastInfo: View {
    var movie: Movie
    var body: some View {
        VStack(spacing: 3) {
            HStack {
                Text("Cast: \(movie.cast)").font(.subheadline)
                Spacer()
            }
            HStack {
                Text("Creators: \(movie.creators)").font(.subheadline)
                Spacer()
            }
        }
        .font(.caption)
        .foregroundColor(.gray)
        .padding(.vertical, 10)
    }
}

struct CurrentEpisodeInformationDisplay: View {
    var movie: Movie
    
    var body: some View {
        Group {
            HStack {
                Text(movie.episodeInfoDisplay).bold()
                Spacer()
            }.padding(.vertical, 4)
            
            HStack {
                Text(movie.episodeDescDisplay).font(.subheadline)
                Spacer()
            }
        }
    }
}
