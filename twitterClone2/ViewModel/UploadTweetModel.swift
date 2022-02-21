//
//  UploadTweetModel.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 27.01.2022.
//

import Foundation
import UIKit
import FirebaseAuth

enum UploadTweetController {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    let actionButtonTitle: String
    let placeholderText: String
    var shouldShowReply: Bool
    var replyText: String?
    
    init(config: UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What`s happening?"
            shouldShowReply = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet your reply"
            shouldShowReply = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
