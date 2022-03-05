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
                // Save images and get URLs
                self.uploadImagesAndGetURLs(userImageRef: self.storageRef.child("users").child(authResult.user.uid).child("images").child("user_image.png"),
                                            headerImageRef: self.storageRef.child("users").child(authResult.user.uid).child("images").child("user_image.png"),
                                            userImage: user.userImage,
                                            headerImage: user.headerImage) { userImageURLString, headerImageURLString in
                    guard let userImageURLString = userImageURLString, let headerImageURLString = headerImageURLString else {
                        completion(.error("Error de images"))
                        return
                    }
                    
                    // Map User to UserDTO
                    guard let newUserDTO = user.map(userID: authResult.user.uid,
                                                    userImageString: userImageURLString,
                                                    headerImageString: headerImageURLString) else {
                        completion(.error("Error de mapeo a UserDTO"))
                        return
                    }
                    
                    // Save data in Realtime and get registered User
                    self.saveUserDataAndGetUserDTO(newUserRef: self.databaseRef.child("users").child(authResult.user.uid),
                                                   newUserDTO: newUserDTO) { registeredUserDTO in
                        guard let registeredUserDTO = registeredUserDTO else {
                            completion(.error("Error de UserDTO nulo"))
                            return
                        }
                        guard let registeredUser = registeredUserDTO.map() else {
                            completion(.error("Error de mapeo a User"))
                            return
                        }
                        completion(.success(registeredUser))
                    }
                }
            } else if let error = error {
                completion(.error(error.localizedDescription))
            }
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
                                }
                                else { completion(nil,nil) }
                            }
                        }
                    }
                    else { completion(nil,nil) }
                }
            }
        }
    }
    
    private func saveUserDataAndGetUserDTO(newUserRef: DatabaseReference, newUserDTO: UserDTO, completion: @escaping ((UserDTO?) -> ())) {
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
                                    completion(registeredUserDTO)
                                } catch { completion(nil) }
                            } else { completion(nil) }
                        }
                    }
                }
            }
        }
        catch { completion(nil) }
    }
}
