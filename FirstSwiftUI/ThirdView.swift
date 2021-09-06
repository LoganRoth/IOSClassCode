//
//  ThirdView.swift
//  FirstSwiftUI
//
//  Created by Logan Roth on 2021-01-09.
//

import SwiftUI

struct ThirdView: View {
    let myArray = ["1", "2", "3"]
    var body: some View {
        List (myArray, id: (\.self)) { element in
            Text(element)
        }
//        List {
//            ForEach(myArray, id: \.self) { element in
//                Text(element)
//            }
//        }
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
