//
//  TweetHeader.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 21.01.2022.
//

import Foundation
import UIKit

protocol TweetHeaderDelegate: AnyObject {
    func showActionSheet()
}

class TweetHeader: UICollectionReusableView {
    //MARK: - Properties
    
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    weak var delegate: TweetHeaderDelegate?
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 49)
        iv.layer.cornerRadius = 48/2
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private let caption: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let datelabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "0:00 PM 1/29/2020"
        return label
    }()
    
    private lazy var optionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .lightGray
        btn.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        btn.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return btn
    }()
    
    private lazy var retweetLabel = UILabel()
    private lazy var likeLabel = UILabel()
    
    private lazy var statsView: UIView = {
        let view = UIView()
        
        let devider1 = UIView()
        devider1.backgroundColor = .systemGroupedBackground
        view.addSubview(devider1)
        devider1.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8,
                        height: 1.0)
        
        let stack = UIStackView(arrangedSubviews: [retweetLabel, likeLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, paddingLeft: 16)
        
        let devider2 = UIView()
        devider2.backgroundColor = .systemGroupedBackground
        view.addSubview(devider2)
        devider2.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 1.0)
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let button = createButton(withImageName: "comment")
        button.addTarget(self, action: #selector(handleCommentButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = createButton(withImageName: "retweet")
        button.addTarget(self, action: #selector(handleRetweetButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeweetButton: UIButton = {
        let button = createButton(withImageName: "like")
        button.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = createButton(withImageName: "retweet")
        button.addTarget(self, action: #selector(handleShareButton), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        let labelStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -10
        
        let stack = UIStackView(arrangedSubviews: [profileImage, labelStack])
        stack.spacing = 12
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(caption)
        caption.anchor(top: stack.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: -16)
        
        addSubview(datelabel)
        datelabel.anchor(top: caption.bottomAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 16)
        
        addSubview(optionButton)
        optionButton.centerY(inView: stack)
        optionButton.anchor(right: rightAnchor, paddingRight: -8)
        
        addSubview(statsView)
        statsView.anchor(top: datelabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, height: 60)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeweetButton, shareButton])
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(top: statsView.bottomAnchor, paddingTop: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        print("DEBUG: Go to user Profile...")
    }
    
    @objc func showActionSheet() {
        delegate?.showActionSheet()
        print("DEBIG: Handle show action...")
    }
    
    @objc func handleCommentButton() {
        
    }
    
    @objc func handleRetweetButton() {
        
    }
    
    @objc func handleLikeButton() {
        
    }
    
    @objc func handleShareButton() {
        
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let tweet = tweet else { return }
        
        let viewModel = TweetViewModel(tweet: tweet)
        
        caption.text = tweet.caprionID
        fullnameLabel.text = tweet.user.fullname
        usernameLabel.text = viewModel.usernameText
        profileImage.sd_setImage(with: viewModel.profileImage)
        datelabel.text = viewModel.headerTimeStap
        retweetLabel.attributedText = viewModel.retweetsAttributedString
        likeLabel.attributedText = viewModel.likeAttributedString
        
    }
    
    func createButton(withImageName imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        return button
    }
    
}
