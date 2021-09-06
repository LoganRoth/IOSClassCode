//
//  SearchBar.swift
//  NetflixClone
//
//  Created by Logan Roth on 2021-01-26.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @Binding var isLoading: Bool
    @State private var isEditting: Bool = true
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            Color.graySearchBG.frame(width: isEditting ? screen.width * 0.75 : screen.width * 0.9, height: 36).cornerRadius(8)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.graySearchText)
                    .padding(.leading, 10)
                
                TextField("Search", text: $text)
                    .background(Color.graySearchBG)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 10)
                    .frame(width: isEditting ? screen.width * 0.75 - 45: screen.width * 0.9 - 45, height: 36)
                    .onTapGesture {
                        isEditting = true
                    }.animation(.default)
                
                
                if !text.isEmpty {
                    if isLoading {
                        Button(action: {
                            //
                        }, label: {
                            ActivityIndicator(style: .medium, animate: .constant(true))
                                .configure {
                                    $0.color = .white
                                }
                                .frame(width: 35, height: 35)
                        }).padding(.trailing, 18)
                        
                        
                    } else {
                        Button(action: {
                            text = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.graySearchText)
                                .frame(width: 35, height: 35)
                        }).padding(.trailing, 18)
                    }
                }
                
                
                if isEditting {
                    Button(action: {
                        text = ""
                        isEditting = false
                        hideKeyboard()
                    }, label: {
                        Text("Cancel").foregroundColor(.white)
                    }).padding(.leading, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                    
                }
                
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            SearchBar(text: .constant(""), isLoading: .constant(false)).padding()
        }
    }
}
