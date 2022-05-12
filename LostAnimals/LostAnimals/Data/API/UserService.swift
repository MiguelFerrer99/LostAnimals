//
//  UserService.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Firebase
import CodableFirebase

// MARK: - Enums
enum GetUserResult {
    case success(User)
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

final class UserService: NSObject {
    // MARK: - Properties
    let databaseRef: DatabaseReference
    let storageRef: StorageReference
    
    // MARK: - Init
    override init() {
        databaseRef = Database.database().reference()
        storageRef = Storage.storage().reference()
    }
}

// MARK: - Functions
extension UserService {
    func getMe(completion: @escaping ((User?) -> ())) {
        if let currentUser = Auth.auth().currentUser {
            self.getUser(id: currentUser.uid) { result in
                switch result {
                case .success(let user): completion(user)
                case .error: completion(nil)
                }
            }
        } else { completion(nil) }
    }
    
    func getUser(id: String, completion: @escaping ((GetUserResult) -> ())) {
        databaseRef.child("users").child(id).getData { error, snapshot in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                if let snapshotValue = snapshot.value {
                    do {
                        let userDTO = try FirebaseDecoder().decode(UserDTO.self, from: snapshotValue)
                        let user = userDTO.map()
                        completion(.success(user))
                    } catch { completion(.error("An unexpected error occured. Please, try again later")) }
                } else { completion(.error("An unexpected error occured. Please, try again later")) }
            }
        }
    }
    
    func deleteAccount(completion: @escaping (DeleteAccountResult) -> Void) {
        guard let me = Auth.auth().currentUser else { return }
        me.delete { error in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                self.databaseRef.child("users").child(me.uid).removeValue { (error, _) in
                    if let error = error {
                        switch error.localizedDescription {
                        case FirebaseError.networkError.rawValue:
                            completion(.error("You don't have an internet connection"))
                        default:
                            completion(.error("An unexpected error occured. Please, try again later"))
                        }
                    } else {
                        self.storageRef.child("users").child(me.uid).child("user_image.png").delete()
                        self.storageRef.child("users").child(me.uid).child("header_image.png").delete()
                        completion(.success)
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
            switch error.localizedDescription {
            case FirebaseError.networkError.rawValue:
                completion(.error("You don't have an internet connection"))
            default:
                completion(.error("An unexpected error occured. Please, try again later"))
            }
        }
    }
}
