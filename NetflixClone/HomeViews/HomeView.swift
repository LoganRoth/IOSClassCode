//
//  HomeView.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-19.
//

import SwiftUI

struct HomeView: View {
    var vm: HomeVM = HomeVM()
    
    let screen = UIScreen.main.bounds
    
    @State private var movieDetailToShow: Movie? = nil
    @State private var topRowSel: HomeTopRow = .home
    @State private var genre: Genre = .AllGenre
    
    
    @State private var showTopPicker: Bool = false
    @State private var showGenrePicker: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            // Main VStack
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
                LazyVStack {
                    
                    
                    TopRowButtons(
                        topSel: $topRowSel,
                        genre: $genre,
                        showTopPicker: $showTopPicker,
                        showGenrePicker: $showGenrePicker
                    ).zIndex(2.0)

                    TopMoviePreview(movie: exampleMovie1)
                        .frame(width: screen.width)
                        .padding(.top, -110)
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/).onTapGesture {
                            movieDetailToShow = exampleMovie1
                        }
                    
                    HomeStack(vm: vm, topRowSel: topRowSel, movieDetailToShow: $movieDetailToShow)
                }
            }
            if movieDetailToShow != nil {
                MovieDetail(movie: movieDetailToShow!, movieDetailToShow: $movieDetailToShow)
                    .animation(.easeIn)
                    .transition(.opacity)
            }
            
//            if showTopPicker {
//                TopRowPickerCover(topRowSel: $topRowSel, showTopPicker: $showTopPicker)
//            }
//            
//            if showGenrePicker {
//                GenrePickerCover(genre: $genre, showGenrePicker: $showGenrePicker)
//            }
        }.foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TopRowButtons: View {
    
    @Binding var topSel: HomeTopRow
    @Binding var genre: Genre
    @Binding var showTopPicker: Bool
    @Binding var showGenrePicker: Bool

    
    var body: some View {
        switch topSel {
        case .home:
            HStack {
                Button(action: {
                    topSel = .home
                }, label: {
                    Text("N").bold().foregroundColor(.red).font(.system(size: 40)).padding(.leading, 10)
                }).buttonStyle(PlainButtonStyle())
                
                HStack {
                    Button(action: {
                        topSel = .tvShows
                    }, label: {
                        Text("TV Shows").font(.system(size: 14))
                    }).buttonStyle(PlainButtonStyle())
                    Spacer()
                    
                    Button(action: {
                        topSel = .movies
                    }, label: {
                        Text("Movies").font(.system(size: 14))
                    }).buttonStyle(PlainButtonStyle())
                    Spacer()
                    
                    Button(action: {
                        topSel = .myList
                    }, label: {
                        Text("My List").font(.system(size: 14))
                    }).buttonStyle(PlainButtonStyle())
                    Spacer()
                }.padding(.horizontal, 30)
            }
        case .movies, .tvShows, .myList:
            HStack {
                Button(action: {
                    topSel = .home
                }, label: {
                    Text("N").bold().foregroundColor(.red).font(.system(size: 40)).padding(.leading, 10)
                }).buttonStyle(PlainButtonStyle())
                
                HStack(spacing: 20) {
                    Button(action: {
                        showTopPicker = true
                    }, label: {
                        HStack {
                            Text(topSel.rawValue).font(.system(size: 14))
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 10))
                                .rotationEffect(.degrees(180), anchor: .center)
                        }
                    }).buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        showGenrePicker = true
                    }, label: {
                        HStack {
                            Text(genre.rawValue).font(.system(size: 12))
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 10))
                                .rotationEffect(.degrees(180), anchor: .center)
                        }
                    }).buttonStyle(PlainButtonStyle())
                    Spacer()
                }.padding(.horizontal, 30)
            }
        }
    }
}

enum HomeTopRow: String, CaseIterable {
    case home = "Home"
    case tvShows = "TV Shows"
    case movies = "Movies"
    case myList = "My List"
}

enum Genre: String {
    case AllGenre = "All Genre"
    case Action
    case Comedy
    case Horror
    case Thriller
    case Crime
}


//struct TopRowPickerCover: View {
//
//    @Binding var topRowSel: HomeTopRow
//    @Binding var showTopPicker: Bool
//
//    var body: some View {
//        Group {
//            Color.black.opacity(0.90)
//            VStack(spacing: 40) {
//                Spacer()
//                ForEach(HomeTopRow.allCases, id: \.self) { oneCase in
//                    Button(action: {
//                        topRowSel = oneCase
//                        showTopPicker = false
//                    }, label: {
//                        Text(oneCase.rawValue)
//                            .bold()
//                            .font(topRowSel == oneCase ? .title : .title2)
//                    }).foregroundColor(topRowSel == oneCase ? .white : .gray)
//                }
//                Spacer()
//                Button(action: {
//                    showTopPicker = false
//                }, label: {
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundColor(.white)
//                        .font(.system(size: 40))
//                        .scaleEffect(x: 1.1)
//                }).padding(.bottom, 30)
//            }
//        }.edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct GenrePickerCover: View {
//    @Binding var genre: Genre
//    @Binding var showGenrePicker: Bool
//
//    var body: some View {
//        Group {
//            Color.black.opacity(0.90)
//            VStack(spacing: 40) {
//                Spacer()
//                ScrollView {
//                    ForEach(Genre.allCases, id: \.self) { oneCase in
//                        Button(action: {
//                            genre = oneCase
//                            showGenrePicker = false
//                        }, label: {
//                            Text(oneCase.rawValue)
//                                .bold()
//                                .font(genre == oneCase ? .title : .title2)
//                        })
//                        .padding(.bottom, 40)
//                        .foregroundColor(genre == oneCase ? .white : .gray)
//                    }
//                    Spacer()
//                    Button(action: {
//                        showGenrePicker = false
//                    }, label: {
//                        Image(systemName: "xmark.circle.fill")
//                            .foregroundColor(.white)
//                            .font(.system(size: 40))
//                            .scaleEffect(x: 1.1)
//                    }).padding(.bottom, 30)
//                }
//            }
//        }.edgesIgnoringSafeArea(.all)
//    }
//}
