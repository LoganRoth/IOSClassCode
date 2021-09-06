//
//  SearchView.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-26.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    @ObservedObject var vm = SearchVM()
    
    var body: some View {
        let searchTextBinding = Binding {
            return searchText
        } set: {
            searchText = $0 // The change is $0
            vm.updateSearchText(with: $0)
        }
        
        return ZStack(alignment: .center) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                SearchBar(text: searchText, isLoading: $vm.isLoading).padding()
                ScrollView {
                    if vm.isShowingPopular {
                        Text("Pop")
                    }
                    if vm.viewState == .empty {
                        Text("Empty")
                    } else if vm.viewState == .ready && !vm.isShowingPopularMovies {
                        Text("Ready")
                    }
                }
                Spacer()
            }
        }.foregroundColor(.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
