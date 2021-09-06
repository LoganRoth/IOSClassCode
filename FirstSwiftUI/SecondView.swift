//
//  SecondView.swift
//  FirstSwiftUI
//
//  Created by Logan Roth on 2021-01-09.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        Image("tattoo").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
