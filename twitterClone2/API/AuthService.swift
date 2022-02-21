//
//  Auth.swift
//  twitterClone2
//
//  Created by Димаш Алтынбек on 11.01.2022.
//

import Foundation

import Firebase

struct AuthCredential {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredential, complition: @escaping(Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullName
        let username = credentials.userName
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImage1 = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG Error is: \(error.localizedDescription)")
                    }
                    
                    guard let uid = result?.user.uid else { return }
                   
                    
                    let values = ["email": email,
                                  "username": username,
                                  "fullname": fullname,
                                  "profile_image": profileImage1]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: complition)
                    
                

                
                
                }
            }
        }
    }
}
