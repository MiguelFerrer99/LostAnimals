//
//  AuthenticationService.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase
import UIKit

enum SignUpResult {
    case success(User)
    case error(String)
}

class AuthenticationService {
    // MARK: - Properties
    var databaseRef: DatabaseReference
    var storageRef: StorageReference
    
    // MARK: - Init
    init() {
        databaseRef = Database.database().reference()
        storageRef = Storage.storage().reference()
    }
    
    // MARK: - AuthenticationService Functions
    func signUp(user: User, userPassword: String, completion: @escaping (SignUpResult) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: userPassword) { authResult, error in
            if let authResult = authResult {
                self.uploadImagesAndGetURLs(userImageRef: self.storageRef.child("users").child(authResult.user.uid).child("images").child("user_image.png"),
                                            headerImageRef: self.storageRef.child("users").child(authResult.user.uid).child("images").child("user_image.png"),
                                            userImage: user.userImage,
                                            headerImage: user.headerImage) { userImageURLString, headerImageURLString in
                    if let userImageURLString = userImageURLString, let headerImageURLString = headerImageURLString {
                        if let newUserDTO = user.map(userID: authResult.user.uid,
                                                     userImageString: userImageURLString,
                                                     headerImageString: headerImageURLString) {
                            self.saveUserDataAndGetUser(newUserRef: self.databaseRef.child("users").child(authResult.user.uid),
                                                           newUserDTO: newUserDTO) { registeredUser in
                                if let registeredUser = registeredUser {
                                    completion(.success(registeredUser))
                                } else { completion(.error("Error de mapeo a User")) }
                            }
                        } else { completion(.error("An unexpected error occured. Please, try again later")) }
                    } else { completion(.error("An unexpected error occured. Please, try again later")) }
                }
            } else if let error = error { completion(.error(error.localizedDescription)) }
        }
    }
    
    // MARK: - Private functions
    private func uploadImagesAndGetURLs(userImageRef: StorageReference, headerImageRef: StorageReference, userImage: UIImage, headerImage: UIImage, completion: @escaping ((String?, String?) -> ())) {
        guard let userImageData = userImage.pngData(), let headerImageData = headerImage.pngData() else { return }
        userImageRef.putData(userImageData, metadata: nil) { (_, error) in
            if error != nil { completion(nil,nil) }
            else {
                userImageRef.downloadURL { (userImageURL, _) in
                    if let userImageURL = userImageURL {
                        headerImageRef.putData(headerImageData, metadata: nil) { (_, error) in
                            headerImageRef.downloadURL { (headerImageURL, _) in
                                if let headerImageURL = headerImageURL {
                                    completion(userImageURL.absoluteString, headerImageURL.absoluteString)
                                } else { completion(nil,nil) }
                            }
                        }
                    } else { completion(nil,nil) }
                }
            }
        }
    }
    
    private func saveUserDataAndGetUser(newUserRef: DatabaseReference, newUserDTO: UserDTO, completion: @escaping ((User?) -> ())) {
        do {
            let userObject = try FirebaseEncoder().encode(newUserDTO)
            newUserRef.setValue(userObject) { (error, _) in
                if error != nil { completion(nil) }
                else {
                    newUserRef.getData { error, snapshot in
                        if error != nil { completion(nil) }
                        else {
                            if let snapshotValue = snapshot.value {
                                do {
                                    let registeredUserDTO = try FirebaseDecoder().decode(UserDTO.self, from: snapshotValue)
                                    registeredUserDTO.map { registeredUser in
                                        if let registeredUser = registeredUser {
                                            completion(registeredUser)
                                        } else { completion(nil) }
                                    }
                                } catch { completion(nil) }
                            } else { completion(nil) }
                        }
                    }
                }
            }
        } catch { completion(nil) }
    }
}
