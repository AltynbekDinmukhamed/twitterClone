//
//  ActionSheetViewModel.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 29.01.2022.
//

import Foundation
import UIKit

struct ActionSheetViewModel {
    
    //MARK: - Properties
    
    private let user: User
    
    var options: [ActionSheetOptions] {
        var result = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            result.append(.delete)
        }else {
            let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            result.append(followOption)
        }
        
        result.append(.report)
        return result
    }
    
    //MARK: - Lifecycle
    init(user: User) {
        self.user = user
    }
}

enum ActionSheetOptions {
    case follow(User)
    case unfollow(User)
    case report
    case delete

    
    var description: String {
        switch self {
        case .follow(let user):
            return "Follow user \(user.username)"
        case .unfollow(let user):
            return "Unfollow user \(user.username)"
        case .report:
            return "Report"
        case .delete:
            return "Delete"

        }
    }
}
