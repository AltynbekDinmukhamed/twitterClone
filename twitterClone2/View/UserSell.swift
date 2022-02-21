//
//  UserSell.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 20.01.2022.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    //MARK: - Properties
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private lazy var ProfileImage: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 40, height: 40)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "username"
        return label
    }()
    
    private let fullname: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "fullname"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(ProfileImage)
        ProfileImage.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullname])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.centerY(inView: ProfileImage, leftAnchor: ProfileImage.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    func configure() {
        guard let user = user else { return }
        
        ProfileImage.sd_setImage(with: user.profile_image)
        
        usernameLabel.text = user.username
        fullname.text = user.fullname
    }
}
