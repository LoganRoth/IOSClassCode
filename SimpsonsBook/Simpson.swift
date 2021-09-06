//
//  Simpson.swift
//  SimpsonsBook
//
//  Created by Logan Roth on 2020-12-21.
//

import Foundation
import UIKit

enum JobType : String {
    case NuclearSafety
    case Mom
    case Student
    case Baby
    var description: String {
        return self.rawValue
    }
}

class Simpson {
    var name : String
    var job : JobType
    var image : UIImage
    
    init(nameInit : String, jobInit : JobType, imageInit : UIImage) {
        self.name = nameInit
        self.job = jobInit
        self.image = imageInit
    }
}
