//
//  AuthenticationService.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Firebase
import CodableFirebase

// MARK: - Enums
enum SignUpResult {
    case success(User)
    case error(String)
}
enum LoginResult {
    case success(User)
    case error(String)
}
enum ForgotPasswordResult {
    case success(String)
    case error(String)
}
enum DeleteAccountResult {
    case success(String)
    case error(String)
}
enum FirebaseError: String {
    case emailAlreadyInUse = "The email address is already in use by another account."
    case networkError = "Network error (such as timeout, interrupted connection or unreachable host) has occurred."
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
}

// MARK: - Functions
extension AuthenticationService {
    func signUp(user: User, userPassword: String, completion: @escaping (SignUpResult) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: userPassword) { authResult, error in
            if let authResult = authResult {
                self.uploadImagesAndGetURLs(userImageRef: self.storageRef.child("default_images").child("user_image.png"),
                                            headerImageRef: self.storageRef.child("default_images").child("header_image.png")) { userImageURLString, headerImageURLString in
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
            } else if let error = error {
                switch error.localizedDescription {
                case FirebaseError.emailAlreadyInUse.rawValue:
                    completion(.error("The email address is already in use by another account"))
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error(error.localizedDescription))
                }
            }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping (LoginResult) -> Void) {
        // TODO: Finish logIn
    }
    
    func forgotPassword(email: String, completion: @escaping (ForgotPasswordResult) -> Void) {
        // TODO: Finish forgotPassword
    }
    
    func deleteAccount(id: String, completion: @escaping (DeleteAccountResult) -> Void) {
        // TODO: Finish deleteAccount (UI too)
    }
}

// MARK: - Private functions
private extension AuthenticationService {
    func uploadImagesAndGetURLs(userImageRef: StorageReference, headerImageRef: StorageReference, completion: @escaping ((String?, String?) -> ())) {
        userImageRef.downloadURL { (userImageURL, _) in
            if let userImageURL = userImageURL {
                headerImageRef.downloadURL { (headerImageURL, _) in
                    if let headerImageURL = headerImageURL {
                        completion(userImageURL.absoluteString, headerImageURL.absoluteString)
                    } else { completion(nil,nil) }
                }
            } else { completion(nil,nil) }
        }
    }
    
    func saveUserDataAndGetUser(newUserRef: DatabaseReference, newUserDTO: UserDTO, completion: @escaping ((User?) -> ())) {
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
