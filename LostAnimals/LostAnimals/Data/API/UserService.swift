//
//  UserService.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

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
    
    func getUser(id: String, completion: @escaping ((UserResult) -> ())) {
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
    
    func deleteAccount(completion: @escaping (GenericResult) -> Void) {
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
    
    func logOut(completion: @escaping (GenericResult) -> Void) {
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
    
    func blockUser(userID: String, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error("An unexpected error occured. Please, try again later"))
            return
        }
        var newBlockedUsers = me.blockedUsers
        newBlockedUsers.append(userID)
        self.databaseRef.child("users").child(me.id).child("blocked_users").setValue(newBlockedUsers) { (error, data) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                self.getMe { user in
                    User.shared = user
                    completion(.success)
                }
            }
        }
    }
    
    func unblockUser(userID: String, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error("An unexpected error occured. Please, try again later"))
            return
        }
        var newBlockedUsers = me.blockedUsers
        newBlockedUsers.removeAll { $0 == userID }
        self.databaseRef.child("users").child(me.id).child("blocked_users").setValue(newBlockedUsers) { (error, data) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                self.getMe { user in
                    User.shared = user
                    completion(.success)
                }
            }
        }
    }
    
    func savePost(postID: String, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error("An unexpected error occured. Please, try again later"))
            return
        }
        var newSavedPosts = me.savedPosts
        newSavedPosts.append(postID)
        self.databaseRef.child("users").child(me.id).child("saved_posts").setValue(newSavedPosts) { (error, data) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                self.getMe { user in
                    User.shared = user
                    completion(.success)
                }
            }
        }
    }
    
    func unsavePost(postID: String, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error("An unexpected error occured. Please, try again later"))
            return
        }
        var newSavedPosts = me.savedPosts
        newSavedPosts.removeAll { $0 == postID }
        self.databaseRef.child("users").child(me.id).child("saved_posts").setValue(newSavedPosts) { (error, data) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                self.getMe { user in
                    User.shared = user
                    completion(.success)
                }
            }
        }
    }
    
    func editUserImage(newImage: UIImage?, imageType: ProfileSettingsImageType, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error("An unexpected error occured. Please, try again later"))
            return
        }
        let newImageName = imageType == .header ? "header_image" : "user_image"
        let newImageUrlName = imageType == .header ? "header_url_image" : "user_url_image"
        if let newImage = newImage, let newImageData = newImage.jpegData(compressionQuality: 0.5) {
            self.storageRef.child("users").child(me.id).child(newImageName).putData(newImageData, metadata: nil) { (_, error1) in
                if let error1 = error1 {
                    switch error1.localizedDescription {
                    case FirebaseError.networkError.rawValue:
                        completion(.error("You don't have an internet connection"))
                    default:
                        completion(.error("An unexpected error occured. Please, try again later"))
                    }
                } else {
                    self.storageRef.child("users").child(me.id).child(newImageName).downloadURL { (url, error2) in
                        if let error2 = error2 {
                            switch error2.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error("You don't have an internet connection"))
                            default:
                                completion(.error("An unexpected error occured. Please, try again later"))
                            }
                        } else if let url = url {
                            self.databaseRef.child("users").child(me.id).child(newImageUrlName).setValue(url.absoluteString) { (error3, _) in
                                if let error3 = error3 {
                                    switch error3.localizedDescription {
                                    case FirebaseError.networkError.rawValue:
                                        completion(.error("You don't have an internet connection"))
                                    default:
                                        completion(.error("An unexpected error occured. Please, try again later"))
                                    }
                                } else {
                                    self.getMe { user in
                                        User.shared = user
                                        completion(.success)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            self.storageRef.child("users").child(me.id).child(newImageName).delete { error1 in
                if let error1 = error1 {
                    switch error1.localizedDescription {
                    case FirebaseError.networkError.rawValue:
                        completion(.error("You don't have an internet connection"))
                    default:
                        completion(.error("An unexpected error occured. Please, try again later"))
                    }
                } else {
                    self.databaseRef.child("users").child(me.id).child(newImageUrlName).removeValue { (error2, _) in
                        if let error2 = error2 {
                            switch error2.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error("You don't have an internet connection"))
                            default:
                                completion(.error("An unexpected error occured. Please, try again later"))
                            }
                        } else {
                            self.getMe { user in
                                User.shared = user
                                completion(.success)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func editUserPersonalDetails(firstname: String? = nil, lastname: String? = nil, birthdate: String? = nil, whereDoYouLive: Location? = nil, animalShelterName: String? = nil, whereCanWeFindYou: Location? = nil, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error("An unexpected error occured. Please, try again later"))
            return
        }
        if me.animalShelter {
            self.databaseRef.child("users").child(me.id).child("firstname").setValue(animalShelterName) { (error1, _) in
                if let error1 = error1 {
                    switch error1.localizedDescription {
                    case FirebaseError.networkError.rawValue:
                        completion(.error("You don't have an internet connection"))
                    default:
                        completion(.error("An unexpected error occured. Please, try again later"))
                    }
                } else {
                    do {
                        let locationObject = try FirebaseEncoder().encode(whereCanWeFindYou)
                        self.databaseRef.child("users").child(me.id).child("location").setValue(locationObject) { (error2, _) in
                            if let error2 = error2 {
                                switch error2.localizedDescription {
                                case FirebaseError.networkError.rawValue:
                                    completion(.error("You don't have an internet connection"))
                                default:
                                    completion(.error("An unexpected error occured. Please, try again later"))
                                }
                            } else {
                                self.getMe { user in
                                    User.shared = user
                                    completion(.success)
                                }
                            }
                        }
                    } catch { completion(.error("An unexpected error occured. Please, try again later")) }
                }
            }
        } else {
            self.databaseRef.child("users").child(me.id).child("firstname").setValue(firstname) { (error1, _) in
                if let error1 = error1 {
                    switch error1.localizedDescription {
                    case FirebaseError.networkError.rawValue:
                        completion(.error("You don't have an internet connection"))
                    default:
                        completion(.error("An unexpected error occured. Please, try again later"))
                    }
                } else {
                    self.databaseRef.child("users").child(me.id).child("lastname").setValue(lastname) { (error2, _) in
                        if let error2 = error2 {
                            switch error2.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error("You don't have an internet connection"))
                            default:
                                completion(.error("An unexpected error occured. Please, try again later"))
                            }
                        } else {
                            self.databaseRef.child("users").child(me.id).child("birthdate").setValue(birthdate) { (error3, _) in
                                if let error3 = error3 {
                                    switch error3.localizedDescription {
                                    case FirebaseError.networkError.rawValue:
                                        completion(.error("You don't have an internet connection"))
                                    default:
                                        completion(.error("An unexpected error occured. Please, try again later"))
                                    }
                                } else {
                                    do {
                                        let locationObject = try FirebaseEncoder().encode(whereDoYouLive)
                                        self.databaseRef.child("users").child(me.id).child("location").setValue(locationObject) { (error4, _) in
                                            if let error4 = error4 {
                                                switch error4.localizedDescription {
                                                case FirebaseError.networkError.rawValue:
                                                    completion(.error("You don't have an internet connection"))
                                                default:
                                                    completion(.error("An unexpected error occured. Please, try again later"))
                                                }
                                            } else {
                                                self.getMe { user in
                                                    User.shared = user
                                                    completion(.success)
                                                }
                                            }
                                        }
                                    } catch { completion(.error("An unexpected error occured. Please, try again later")) }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func editUserSocialMediasDetails(phonePrefix: String? = nil, phoneNumber: String? = nil, whatsapp: String? = nil, instagram: String? = nil, twitter: String? = nil, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error("An unexpected error occured. Please, try again later"))
            return
        }
        self.databaseRef.child("users").child(me.id).child("social_medias").child("phone_prefix").setValue(phonePrefix) { (error1, _) in
            if let error1 = error1 {
                switch error1.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else {
                self.databaseRef.child("users").child(me.id).child("social_medias").child("phone_number").setValue(phoneNumber) { (error2, _) in
                    if let error2 = error2 {
                        switch error2.localizedDescription {
                        case FirebaseError.networkError.rawValue:
                            completion(.error("You don't have an internet connection"))
                        default:
                            completion(.error("An unexpected error occured. Please, try again later"))
                        }
                    } else {
                        self.databaseRef.child("users").child(me.id).child("social_medias").child("whatsapp").setValue(whatsapp) { (error3, _) in
                            if let error3 = error3 {
                                switch error3.localizedDescription {
                                case FirebaseError.networkError.rawValue:
                                    completion(.error("You don't have an internet connection"))
                                default:
                                    completion(.error("An unexpected error occured. Please, try again later"))
                                }
                            } else {
                                self.databaseRef.child("users").child(me.id).child("social_medias").child("instagram").setValue(instagram) { (error4, _) in
                                    if let error4 = error4 {
                                        switch error4.localizedDescription {
                                        case FirebaseError.networkError.rawValue:
                                            completion(.error("You don't have an internet connection"))
                                        default:
                                            completion(.error("An unexpected error occured. Please, try again later"))
                                        }
                                    } else {
                                        self.databaseRef.child("users").child(me.id).child("social_medias").child("twitter").setValue(twitter) { (error5, _) in
                                            if let error5 = error5 {
                                                switch error5.localizedDescription {
                                                case FirebaseError.networkError.rawValue:
                                                    completion(.error("You don't have an internet connection"))
                                                default:
                                                    completion(.error("An unexpected error occured. Please, try again later"))
                                                }
                                            } else {
                                                self.getMe { user in
                                                    User.shared = user
                                                    completion(.success)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
