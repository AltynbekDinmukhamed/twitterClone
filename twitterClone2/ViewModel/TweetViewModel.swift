//
//  TweetViewModel.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 13.01.2022.
//

import Foundation
import UIKit

struct TweetViewModel {
    //MARK: -properties
    let tweet: Tweet
    let user: User
    var profileImage: URL {
        return tweet.user.profile_image!
    }
    
    var timestaps: String {
        let date = DateComponentsFormatter()
        date.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        date.maximumUnitCount = 1
        date.unitsStyle = .abbreviated
        let now = Date()
        return date.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    var usernameText: String {
        return "@\(user.username)"
    }
    
    var headerTimeStap: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ∙ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    var retweetsAttributedString: NSAttributedString? {
        return attributedText(withValue: tweet.retweetCounter, text: " Retweets")
    }
    
    var likeAttributedString: NSAttributedString? {
        return attributedText(withValue: tweet.likes, text: " Likes")
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 12)])
        title.append(NSAttributedString(string: " @\(user.username)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                     .foregroundColor: UIColor.lightGray]))
        return title
    }
    
   // var likeButton: UIColor = {
   //     return tweet.didLike ? .red : .lightGray
    //}()
    
    //var likeButtonImage: UIImage = {
      //  let ImageName = tweet.didLike ? "like_filled" : "like"
        //return UIImage(named: ImageName)!
    //}()
    
    // MARK: -lifecycle
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(value)",
                                                         attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "\(text)",
                                                   attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                .foregroundColor: UIColor.lightGray]))
        return attributedString
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
        measurementLabel.text = tweet.caprionID
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
    }
}
