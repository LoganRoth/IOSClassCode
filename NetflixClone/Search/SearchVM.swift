//
//  SearchVM.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-26.
//

import Foundation
import SwiftUI

class SearchVM: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var viewState: ViewState = ViewState.ready
    
    @Published var popularMovies: [Movie] = []
    @Published var searchResults: [Movie] = []
        
    @Published var isShowingPopular: Bool = true
    
    init() {
        getPopularMovies()
    }
    
    public func updateSearchText(with text: String) {
        setViewState(to: .loading)
        
        if text.count > 0 {
            isShowingPopular = false
            getSearchResults(forText: text)
        } else {
            isShowingPopular = true
        }
        
    }
    
    private func getPopularMovies() {
        self.popularMovies = generateMovies(40)
    }
    
    private func getSearchResults(forText text: String) {
        
        let haveResult = Int.random(in: 0...3)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if haveResult == 0 {
                self.searchResults = []
                self.setViewState(to: .empty)
            } else {
                self.searchResults = generateMovies(21)
                self.setViewState(to: .ready)
            }
        }
        
    }
    
    private func setViewState(to state: ViewState) {
        DispatchQueue.main.async {
            self.viewState = state
            self.isLoading = state == .loading
        }
    }
}

enum ViewState {
    case empty
    case loading
    case ready
    case error
}
