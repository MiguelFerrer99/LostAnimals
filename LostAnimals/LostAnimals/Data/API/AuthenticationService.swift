//
//  AuthenticationService.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Firebase
import CodableFirebase
import UIKit

// MARK: - Enums
enum LogInResult {
    case success(User)
    case error(String)
}
enum ForgotPasswordResult {
    case success
    case error(String)
}
enum SignUpResult {
    case success
    case error(String)
}
enum DeleteAccountResult {
    case success
    case error(String)
}
enum LogOutResult {
    case success
    case error(String)
}
enum FirebaseError: String {
    case emailOrPasswordIncorrect = "The password is invalid or the user does not have a password."
    case userNotExists = "There is no user record corresponding to this identifier. The user may have been deleted."
    case emailAlreadyInUse = "The email address is already in use by another account."
    case networkError = "Network error (such as timeout, interrupted connection or unreachable host) has occurred."
}

class AuthenticationService {
    // MARK: - Properties
    let databaseRef: DatabaseReference
    let storageRef: StorageReference
    
    // MARK: - Init
    init() {
        databaseRef = Database.database().reference()
        storageRef = Storage.storage().reference()
    }
}

// MARK: - Functions
extension AuthenticationService {
    func logIn(email: String, password: String, completion: @escaping (LogInResult) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let authResult = authResult {
                if authResult.user.isEmailVerified {
                    self.getUser(userRef: self.databaseRef.child("users").child(authResult.user.uid)) { loggedUser in
                        if let loggedUser = loggedUser {
                            completion(.success(loggedUser))
                        } else {
                            completion(.error("An unexpected error occured. Please, try again later"))
                        }
                    }
                } else {
                    self.sendVerificationEmail(user: authResult.user) { ok in
                        if ok { completion(.error("Verify your account before log in. We have sent you an email")) }
                        else { completion(.error("An unexpected error occured. Please, try again later")) }
                    }
                }
            } else if let error = error {
                switch error.localizedDescription {
                case FirebaseError.userNotExists.rawValue,
                    FirebaseError.emailOrPasswordIncorrect.rawValue:
                    completion(.error("Email or password                                                                                                            incorrect"))
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error(error.localizedDescription))
                }
            }
        }
    }
    
    func forgotPassword(email: String, completion: @escaping (ForgotPasswordResult) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else { completion(.success) }
        }
    }
    
    func signUp(user: User, userPassword: String, completion: @escaping (SignUpResult) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: userPassword) { (authResult, error) in
            if let authResult = authResult {
                self.uploadImagesAndGetURLs(userImageRef: self.storageRef.child("users").child(authResult.user.uid).child("user_image.png"),
                                            headerImageRef: self.storageRef.child("users").child(authResult.user.uid).child("header_image.png"),
                                            userImage: user.userImage,
                                            headerImage: user.headerImage) { (userImageURLString, headerImageURLString) in
                    if let userImageURLString = userImageURLString, let headerImageURLString = headerImageURLString {
                        if let newUserDTO = user.map(userID: authResult.user.uid,
                                                     userImageString: userImageURLString,
                                                     headerImageString: headerImageURLString) {
                            do {
                                let userObject = try FirebaseEncoder().encode(newUserDTO)
                                self.databaseRef.child("users").child(newUserDTO.id).setValue(userObject) { (error, _) in
                                    if error != nil { completion(.error("An unexpected error occured. Please, try again later")) }
                                    else {
                                        self.sendVerificationEmail(user: authResult.user) { ok in
                                            if ok { completion(.success) }
                                            else { completion(.error("An unexpected error occured. Please, try again later")) }
                                        }
                                    }
                                }
                            } catch {
                                completion(.error("An unexpected error occured. Please, try again later"))
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
    
    func deleteAccount(id: String, completion: @escaping (DeleteAccountResult) -> Void) {
        guard let loggedUser = Auth.auth().currentUser else { return }
        databaseRef.child("users").child(id).removeValue { (error, _) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                self.storageRef.child("users").child(id).delete { error in
                    if let error = error {
                        switch error.localizedDescription {
                        case FirebaseError.networkError.rawValue:
                            completion(.error("You don't have an internet connection"))
                        default:
                            completion(.error("An unexpected error occured. Please, try again later"))
                        }
                    } else {
                        loggedUser.delete { error in
                            if let error = error {
                                switch error.localizedDescription {
                                case FirebaseError.networkError.rawValue:
                                    completion(.error("You don't have an internet connection"))
                                default:
                                    completion(.error("An unexpected error occured. Please, try again later"))
                                }
                            } else { completion(.success) }
                        }
                    }
                }
            }
        }
    }
    
    func logOut(completion: @escaping (LogOutResult) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success)
        } catch {
            completion(.error(error.localizedDescription))
        }
    }
}

// MARK: - Private functions
private extension AuthenticationService {
    func uploadImagesAndGetURLs(userImageRef: StorageReference, headerImageRef: StorageReference, userImage: UIImage, headerImage: UIImage, completion: @escaping ((String?, String?) -> ())) {
        guard let userImageData = userImage.pngData(),
              let headerImageData = headerImage.pngData() else { return }
        userImageRef.putData(userImageData, metadata: nil) { (_, error) in
            if error != nil { completion(nil, nil) }
            else {
                userImageRef.downloadURL { (userImageURL, _) in
                    if let userImageURL = userImageURL {
                        headerImageRef.putData(headerImageData, metadata: nil) { (_, error) in
                            if error != nil { completion(nil, nil) }
                            else {
                                headerImageRef.downloadURL { (headerImageURL, _) in
                                    if let headerImageURL = headerImageURL {
                                        completion(userImageURL.absoluteString, headerImageURL.absoluteString)
                                    } else { completion(nil,nil) }
                                }
                            }
                        }
                    } else { completion(nil,nil) }
                }
            }
        }
    }
    
    func getUser(userRef: DatabaseReference, completion: @escaping ((User?) -> ())) {
        userRef.getData { error, snapshot in
            if error != nil { completion(nil) }
            else {
                if let snapshotValue = snapshot.value {
                    do {
                        let userDTO = try FirebaseDecoder().decode(UserDTO.self, from: snapshotValue)
                        userDTO.map { user in
                            if let user = user { completion(user) }
                            else { completion(nil) }
                        }
                    } catch { completion(nil) }
                } else { completion(nil) }
            }
        }
    }
    
    func sendVerificationEmail(user: Firebase.User, completion: @escaping ((Bool) -> ())) {
        user.sendEmailVerification { error in
            if error != nil { completion(false) }
            else { completion(true) }
        }
    }
}
