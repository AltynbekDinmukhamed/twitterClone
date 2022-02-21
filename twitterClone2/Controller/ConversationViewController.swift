//
//  ConversationViewController.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 10.01.2022.
//

import UIKit
import Firebase

class ConversationViewController: UIViewController {
    //MARK: - Properties
    let buttonlogOut: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.addTarget(self, action: #selector(handleButtonLogOut), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleButtonLogOut() {
        do {
            try Auth.auth().signOut()
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
            
            guard let tab = window.rootViewController as? MainTapController else { return }
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }catch let error {
            print("DEBUG: Failde to sign out with error: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Message"
        
        view.addSubview(buttonlogOut)
        buttonlogOut.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, width: 50, height: 50)
    }

}
