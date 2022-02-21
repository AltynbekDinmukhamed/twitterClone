//
//  Model.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 11.01.2022.
//

import Foundation
import Firebase
struct User {
    let fullname: String
    let email: String
    let username: String
    var profile_image: URL?
    let uid: String
    var isFollowed = false
    var stats: UserRelationStat?
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionary: [String: AnyObject]){
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        if let profile_imageURL = dictionary["profile_image"] as? String {
            guard let url = URL(string: profile_imageURL) else { return }
            self.profile_image = url
        }
        
    }
}

struct UserRelationStat {
    let followers: Int
    var following: Int
}
