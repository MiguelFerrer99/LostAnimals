//
//  UserService.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Firebase
import CodableFirebase
import UIKit

// MARK: - Enums
enum DeleteAccountResult {
    case success
    case error(String)
}
enum LogOutResult {
    case success
    case error(String)
}

final class UserService {
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
extension UserService {
    func getUser(id: String, completion: @escaping ((User?) -> ())) {
        databaseRef.child("users").child(id).getData { error, snapshot in
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
    
    func deleteAccount(id: String, completion: @escaping (DeleteAccountResult) -> Void) {
        guard let loggedUser = Auth.auth().currentUser else { return }
        storageRef.child("users").child(id).child("user_image.png").delete { error in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                self.storageRef.child("users").child(id).child("header_image.png").delete { error in
                    if let error = error {
                        switch error.localizedDescription {
                        case FirebaseError.networkError.rawValue:
                            completion(.error("You don't have an internet connection"))
                        default:
                            completion(.error("An unexpected error occured. Please, try again later"))
                        }
                    } else {
                        self.databaseRef.child("users").child(id).removeValue { (error, _) in
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
