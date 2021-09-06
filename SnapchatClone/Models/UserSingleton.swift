//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Logan Roth on 2021-01-09.
//

import Foundation

class UserSingleton {
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {}
}
