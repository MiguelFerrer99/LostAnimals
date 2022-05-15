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
enum GenericResult {
    case success
    case error(String)
}

enum LogInResult {
    case success(User)
    case error(String)
}

enum FirebaseError: String {
    case emailOrPasswordIncorrect = "The password is invalid or the user does not have a password."
    case userNotExists = "There is no user record corresponding to this identifier. The user may have been deleted."
    case emailAlreadyInUse = "The email address is already in use by another account."
    case networkError = "Network error (such as timeout, interrupted connection or unreachable host) has occurred."
}

final class AuthenticationService {
    // MARK: - Properties
    let userService: UserService
    let databaseRef: DatabaseReference
    let storageRef: StorageReference
    
    // MARK: - Init
    init() {
        userService = UserService()
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
                    self.userService.getMe { me in
                        if let me = me { completion(.success(me)) }
                        else { completion(.error("An unexpected error occured. Please, try again later")) }
                    }
                } else { completion(.error("Verify your account before log in")) }
            } else if let error = error {
                switch error.localizedDescription {
                case FirebaseError.userNotExists.rawValue,
                    FirebaseError.emailOrPasswordIncorrect.rawValue:
                    completion(.error("Email or password incorrect"))
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error(error.localizedDescription))
                }
            }
        }
    }
    
    func forgotPassword(email: String, completion: @escaping (GenericResult) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                case FirebaseError.userNotExists.rawValue:
                    completion(.error("There is no user registered with this email"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else { completion(.success) }
        }
    }
    
    func signUp(user: User, userPassword: String, completion: @escaping (GenericResult) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: userPassword) { (authResult, error) in
            if let authResult = authResult {
                var newUser = user
                newUser.id = authResult.user.uid
                if let newUserDTO = newUser.map() {
                    do {
                        let userObject = try FirebaseEncoder().encode(newUserDTO)
                        self.databaseRef.child("users").child(newUser.id).setValue(userObject) { (error, _) in
                            if error != nil { completion(.error("An unexpected error occured. Please, try again later")) }
                            else {
                                authResult.user.sendEmailVerification { error in
                                    if error != nil { completion(.error("An unexpected error occured. Please, try again later")) }
                                    else { completion(.success) }
                                }
                            }
                        }
                    } catch { completion(.error("An unexpected error occured. Please, try again later")) }
                } else { completion(.error("An unexpected error occured. Please, try again later")) }
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
}
