//
//  FourthView.swift
//  FirstSwiftUI
//
//  Created by Logan Roth on 2021-01-09.
//

import SwiftUI

struct FourthView: View {
    @State var name = ""
    
    var body: some View {
        VStack {
            
            Text(name).padding()
            
            TextField("New Name", text: $name)
            Button(action: {
                self.name = "Test"
            }, label: {
                Text("Present Name")
            })
        }
    }
}

struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView()
    }
}
