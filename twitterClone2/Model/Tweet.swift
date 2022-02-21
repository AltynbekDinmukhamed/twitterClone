//
//  Tweet.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 12.01.2022.
//

import Foundation
import UIKit
import Firebase

struct Tweet {
    let caprionID: String
    let tweetID: String
    let uid: String
    var likes: Int
    var timestamp: Date!
    let retweetCounter: Int
    var user: User
    var didLike = false
    
    init(user: User ,tweet: String, dictionary: [String: Any]) {
        self.tweetID = tweet
        self.user = user
        
        self.caprionID = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCounter = dictionary["retweets"] as? Int ?? 0
        
        if let timestep = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestep)
        }
    }
    
}

