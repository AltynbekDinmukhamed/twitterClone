//
//  NotificationViewController.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 10.01.2022.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    

    func configureUI(){
        view.backgroundColor = .white
        
        navigationItem.title = "Notification"
    }

}
