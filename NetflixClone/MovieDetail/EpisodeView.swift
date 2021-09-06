//
//  EpisodeView.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-24.
//

import SwiftUI

struct EpisodeView: View {
    
    var episodes: [Episode]
    
    @Binding var showSeasonPicker: Bool
    
    @Binding var selSeason: Int
    
    func getEpisodes(forSeason season: Int) -> [Episode] {
        return episodes.filter({ $0.season == season })
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Season Picker
            HStack {
                Button(action: {
                    showSeasonPicker = true
                }, label: {
                    Group {
                        Text("Season \(selSeason)")
                        Image(systemName: "chevron.down")
                    }.font(.system(size: 16))
                })
                
                Spacer()
            }
            
            // Episodes List
            ForEach(getEpisodes(forSeason: selSeason)) { episode in
                VStack(alignment: .leading) {
                    HStack {
                        VideoPreviewImage(imageURL: episode.thumbnail, videoURL: episode.videoURL).frame(width: 120, height: 70).clipped()
                        VStack(alignment: .leading) {
                            Text("\(episode.episodeNumber). \(episode.name)")
                            Text("\(episode.length)m").font(.system(size: 12)).foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "arrow.down.to.line.alt").font(.system(size: 20))
                    }
                    Text(episode.description).font(.system(size: 15)).lineLimit(3)
                }.padding(.bottom, 20)
            }
            
            
            Spacer()
        }.foregroundColor(.white).padding(.horizontal, 20)
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            EpisodeView(episodes: [episode1, episode2, episode3], showSeasonPicker: .constant(false), selSeason: .constant(1))
        }
    }
}
