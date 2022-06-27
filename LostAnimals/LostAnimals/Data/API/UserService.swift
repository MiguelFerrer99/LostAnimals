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

// MARK: - Enums
enum GetUsersResult {
    case success([User])
    case error(String)
}

final class UserService {
    // MARK: - Properties
    let databaseRef: DatabaseReference
    let storageRef: StorageReference
    
    // MARK: - Services
    let postService = PostService()
    
    // MARK: - Init
    init() {
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
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
                }
            } else {
                if let snapshotValue = snapshot.value {
                    do {
                        let userDTO = try FirebaseDecoder().decode(UserDTO.self, from: snapshotValue)
                        let user = userDTO.map()
                        completion(.success(user))
                    } catch { completion(.error(.ServiceErrors.Unexpected())) }
                } else { completion(.error(.ServiceErrors.Unexpected())) }
            }
        }
    }
    
    func getBlockedUsers(completion: @escaping (GetUsersResult) -> Void) {
        guard let me = User.shared else {
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        databaseRef.child("users").getData { (error, snapshot) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
                }
            } else if let snapshotValue = snapshot.value as? [String: Any] {
                do {
                    let usersDTO = try FirebaseDecoder().decode([UserDTO].self, from: Array(snapshotValue.values))
                    var users = usersDTO.compactMap { $0.map() }
                    users = users.filter { me.blockedUsers.contains($0.id) }
                    completion(.success(users))
                } catch { completion(.error(.ServiceErrors.Unexpected())) }
            } else { completion(.success([])) }
        }
    }
    
    func getPosts(completion: @escaping (GetPostsResult) -> Void) {
        databaseRef.child("posts").getData { (error, snapshot) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
                }
            } else if let snapshotValue = snapshot.value as? [String: Any] {
                do {
                    let postsDTO = try FirebaseDecoder().decode([PostDTO].self, from: Array(snapshotValue.values))
                    var posts = postsDTO.compactMap { $0.map() }
                    posts = posts.filter { !(User.shared?.blockedUsers.contains($0.userID) ?? false) }
                    posts.sort { $0.createdAt > $1.createdAt }
                    completion(.success(posts))
                } catch { completion(.error(.ServiceErrors.Unexpected())) }
            } else { completion(.success([])) }
        }
    }
    
    func changePassword(newPassword: String, completion: @escaping (GenericResult) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            currentUser.updatePassword(to: newPassword) { error in
                if let error = error {
                    switch error.localizedDescription {
                    case FirebaseError.networkError.rawValue:
                        completion(.error(.ServiceErrors.InternetConnection()))
                    default:
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
                } else { completion(.success) }
            }
        } else { completion(.error(.ServiceErrors.Unexpected())) }
    }
    
    func deleteMyPosts() {
        var myPosts = [Post]()
        self.getPosts { postsResult in
            switch postsResult {
            case .success(let posts):
                myPosts = posts.filter { User.shared?.id == $0.userID }
                myPosts.forEach { self.deletePost(post: $0) { _ in } }
            case .error: return
            }
        }
    }
    
    func deleteAccount(completion: @escaping (GenericResult) -> Void) {
        guard let me = Auth.auth().currentUser else { return }
        me.delete { error in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
                }
            } else {
                self.databaseRef.child("users").child(me.uid).removeValue { (error, _) in
                    if let error = error {
                        switch error.localizedDescription {
                        case FirebaseError.networkError.rawValue:
                            completion(.error(.ServiceErrors.InternetConnection()))
                        default:
                            completion(.error(.ServiceErrors.Unexpected()))
                        }
                    } else {
                        self.storageRef.child("users").child(me.uid).child("user_image.png").delete()
                        self.storageRef.child("users").child(me.uid).child("header_image.png").delete()
                        self.deleteMyPosts()
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
                completion(.error(.ServiceErrors.InternetConnection()))
            default:
                completion(.error(.ServiceErrors.Unexpected()))
            }
        }
    }
    
    func blockUser(userID: String, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        var newBlockedUsers = me.blockedUsers
        newBlockedUsers.append(userID)
        self.databaseRef.child("users").child(me.id).child("blocked_users").setValue(newBlockedUsers) { (error, data) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
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
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        var newBlockedUsers = me.blockedUsers
        newBlockedUsers.removeAll { $0 == userID }
        self.databaseRef.child("users").child(me.id).child("blocked_users").setValue(newBlockedUsers) { (error, data) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
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
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        var newSavedPosts = me.savedPosts
        newSavedPosts.append(postID)
        self.databaseRef.child("users").child(me.id).child("saved_posts").setValue(newSavedPosts) { (error, data) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
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
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        var newSavedPosts = me.savedPosts
        newSavedPosts.removeAll { $0 == postID }
        self.databaseRef.child("users").child(me.id).child("saved_posts").setValue(newSavedPosts) { (error, data) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
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
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        let newImageName = imageType == .header ? "header_image" : "user_image"
        let newImageUrlName = imageType == .header ? "header_url_image" : "user_url_image"
        if let newImage = newImage, let newImageData = newImage.jpegData(compressionQuality: 0.0) {
            self.storageRef.child("users").child(me.id).child(newImageName).putData(newImageData, metadata: nil) { (_, error1) in
                if let error1 = error1 {
                    switch error1.localizedDescription {
                    case FirebaseError.networkError.rawValue:
                        completion(.error(.ServiceErrors.InternetConnection()))
                    default:
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
                } else {
                    self.storageRef.child("users").child(me.id).child(newImageName).downloadURL { (url, error2) in
                        if let error2 = error2 {
                            switch error2.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error(.ServiceErrors.InternetConnection()))
                            default:
                                completion(.error(.ServiceErrors.Unexpected()))
                            }
                        } else if let url = url {
                            self.databaseRef.child("users").child(me.id).child(newImageUrlName).setValue(url.absoluteString) { (error3, _) in
                                if let error3 = error3 {
                                    switch error3.localizedDescription {
                                    case FirebaseError.networkError.rawValue:
                                        completion(.error(.ServiceErrors.InternetConnection()))
                                    default:
                                        completion(.error(.ServiceErrors.Unexpected()))
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
                        completion(.error(.ServiceErrors.InternetConnection()))
                    default:
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
                } else {
                    self.databaseRef.child("users").child(me.id).child(newImageUrlName).removeValue { (error2, _) in
                        if let error2 = error2 {
                            switch error2.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error(.ServiceErrors.InternetConnection()))
                            default:
                                completion(.error(.ServiceErrors.Unexpected()))
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
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        if me.animalShelter {
            self.databaseRef.child("users").child(me.id).child("firstname").setValue(animalShelterName) { (error1, _) in
                if let error1 = error1 {
                    switch error1.localizedDescription {
                    case FirebaseError.networkError.rawValue:
                        completion(.error(.ServiceErrors.InternetConnection()))
                    default:
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
                } else {
                    do {
                        let locationObject = try FirebaseEncoder().encode(whereCanWeFindYou)
                        self.databaseRef.child("users").child(me.id).child("location").setValue(locationObject) { (error2, _) in
                            if let error2 = error2 {
                                switch error2.localizedDescription {
                                case FirebaseError.networkError.rawValue:
                                    completion(.error(.ServiceErrors.InternetConnection()))
                                default:
                                    completion(.error(.ServiceErrors.Unexpected()))
                                }
                            } else {
                                self.getMe { user in
                                    User.shared = user
                                    completion(.success)
                                }
                            }
                        }
                    } catch { completion(.error(.ServiceErrors.Unexpected())) }
                }
            }
        } else {
            self.databaseRef.child("users").child(me.id).child("firstname").setValue(firstname) { (error1, _) in
                if let error1 = error1 {
                    switch error1.localizedDescription {
                    case FirebaseError.networkError.rawValue:
                        completion(.error(.ServiceErrors.InternetConnection()))
                    default:
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
                } else {
                    self.databaseRef.child("users").child(me.id).child("lastname").setValue(lastname) { (error2, _) in
                        if let error2 = error2 {
                            switch error2.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error(.ServiceErrors.InternetConnection()))
                            default:
                                completion(.error(.ServiceErrors.Unexpected()))
                            }
                        } else {
                            self.databaseRef.child("users").child(me.id).child("birthdate").setValue(birthdate) { (error3, _) in
                                if let error3 = error3 {
                                    switch error3.localizedDescription {
                                    case FirebaseError.networkError.rawValue:
                                        completion(.error(.ServiceErrors.InternetConnection()))
                                    default:
                                        completion(.error(.ServiceErrors.Unexpected()))
                                    }
                                } else {
                                    do {
                                        let locationObject = try FirebaseEncoder().encode(whereDoYouLive)
                                        self.databaseRef.child("users").child(me.id).child("location").setValue(locationObject) { (error4, _) in
                                            if let error4 = error4 {
                                                switch error4.localizedDescription {
                                                case FirebaseError.networkError.rawValue:
                                                    completion(.error(.ServiceErrors.InternetConnection()))
                                                default:
                                                    completion(.error(.ServiceErrors.Unexpected()))
                                                }
                                            } else {
                                                self.getMe { user in
                                                    User.shared = user
                                                    completion(.success)
                                                }
                                            }
                                        }
                                    } catch { completion(.error(.ServiceErrors.Unexpected())) }
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
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        self.databaseRef.child("users").child(me.id).child("social_medias").child("phone_prefix").setValue(phonePrefix) { (error1, _) in
            if let error1 = error1 {
                switch error1.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
                }
            } else {
                self.databaseRef.child("users").child(me.id).child("social_medias").child("phone_number").setValue(phoneNumber) { (error2, _) in
                    if let error2 = error2 {
                        switch error2.localizedDescription {
                        case FirebaseError.networkError.rawValue:
                            completion(.error(.ServiceErrors.InternetConnection()))
                        default:
                            completion(.error(.ServiceErrors.Unexpected()))
                        }
                    } else {
                        self.databaseRef.child("users").child(me.id).child("social_medias").child("whatsapp").setValue(whatsapp) { (error3, _) in
                            if let error3 = error3 {
                                switch error3.localizedDescription {
                                case FirebaseError.networkError.rawValue:
                                    completion(.error(.ServiceErrors.InternetConnection()))
                                default:
                                    completion(.error(.ServiceErrors.Unexpected()))
                                }
                            } else {
                                self.databaseRef.child("users").child(me.id).child("social_medias").child("instagram").setValue(instagram) { (error4, _) in
                                    if let error4 = error4 {
                                        switch error4.localizedDescription {
                                        case FirebaseError.networkError.rawValue:
                                            completion(.error(.ServiceErrors.InternetConnection()))
                                        default:
                                            completion(.error(.ServiceErrors.Unexpected()))
                                        }
                                    } else {
                                        self.databaseRef.child("users").child(me.id).child("social_medias").child("twitter").setValue(twitter) { (error5, _) in
                                            if let error5 = error5 {
                                                switch error5.localizedDescription {
                                                case FirebaseError.networkError.rawValue:
                                                    completion(.error(.ServiceErrors.InternetConnection()))
                                                default:
                                                    completion(.error(.ServiceErrors.Unexpected()))
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
    
    func deletePost(post: Post, completion: @escaping (GenericResult) -> Void) {
        self.databaseRef.child("posts").child(post.id).removeValue { (error, _) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
                }
            } else {
                if post.urlImage1 != nil {
                    self.storageRef.child("posts").child(post.id).child("post_image1").delete { error in
                        if let error = error {
                            switch error.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error(.ServiceErrors.InternetConnection()))
                            default:
                                completion(.error(.ServiceErrors.Unexpected()))
                            }
                        } else {
                            if post.urlImage2 != nil {
                                self.storageRef.child("posts").child(post.id).child("post_image2").delete { error in
                                    if let error = error {
                                        switch error.localizedDescription {
                                        case FirebaseError.networkError.rawValue:
                                            completion(.error(.ServiceErrors.InternetConnection()))
                                        default:
                                            completion(.error(.ServiceErrors.Unexpected()))
                                        }
                                    } else {
                                        if post.urlImage3 != nil {
                                            self.storageRef.child("posts").child(post.id).child("post_image3").delete { error in
                                                if let error = error {
                                                    switch error.localizedDescription {
                                                    case FirebaseError.networkError.rawValue:
                                                        completion(.error(.ServiceErrors.InternetConnection()))
                                                    default:
                                                        completion(.error(.ServiceErrors.Unexpected()))
                                                    }
                                                } else {
                                                    if post.urlImage4 != nil {
                                                        self.storageRef.child("posts").child(post.id).child("post_image4").delete { error in
                                                            if let error = error {
                                                                switch error.localizedDescription {
                                                                case FirebaseError.networkError.rawValue:
                                                                    completion(.error(.ServiceErrors.InternetConnection()))
                                                                default:
                                                                    completion(.error(.ServiceErrors.Unexpected()))
                                                                }
                                                            } else {
                                                                if post.urlImage5 != nil {
                                                                    self.storageRef.child("posts").child(post.id).child("post_image5").delete { error in
                                                                        if let error = error {
                                                                            switch error.localizedDescription {
                                                                            case FirebaseError.networkError.rawValue:
                                                                                completion(.error(.ServiceErrors.InternetConnection()))
                                                                            default:
                                                                                completion(.error(.ServiceErrors.Unexpected()))
                                                                            }
                                                                        } else {
                                                                            if post.urlImage6 != nil {
                                                                                self.storageRef.child("posts").child(post.id).child("post_image6").delete { error in
                                                                                    if let error = error {
                                                                                        switch error.localizedDescription {
                                                                                        case FirebaseError.networkError.rawValue:
                                                                                            completion(.error(.ServiceErrors.InternetConnection()))
                                                                                        default:
                                                                                            completion(.error(.ServiceErrors.Unexpected()))
                                                                                        }
                                                                                    } else {
                                                                                        if post.urlImage7 != nil {
                                                                                            self.storageRef.child("posts").child(post.id).child("post_image7").delete { error in
                                                                                                if let error = error {
                                                                                                    switch error.localizedDescription {
                                                                                                    case FirebaseError.networkError.rawValue:
                                                                                                        completion(.error(.ServiceErrors.InternetConnection()))
                                                                                                    default:
                                                                                                        completion(.error(.ServiceErrors.Unexpected()))
                                                                                                    }
                                                                                                } else {
                                                                                                    if post.urlImage8 != nil {
                                                                                                        self.storageRef.child("posts").child(post.id).child("post_image8").delete { error in
                                                                                                            if let error = error {
                                                                                                                switch error.localizedDescription {
                                                                                                                case FirebaseError.networkError.rawValue:
                                                                                                                    completion(.error(.ServiceErrors.InternetConnection()))
                                                                                                                default:
                                                                                                                    completion(.error(.ServiceErrors.Unexpected()))
                                                                                                                }
                                                                                                            } else {
                                                                                                                if User.shared?.savedPosts.contains(post.id) ?? false {
                                                                                                                    self.unsavePost(postID: post.id) { result in
                                                                                                                        switch result {
                                                                                                                        case .success:
                                                                                                                            completion(.success)
                                                                                                                        case .error(let error):
                                                                                                                            completion(.error(error))
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    } else { completion(.success) }
                                                                                                }
                                                                                            }
                                                                                        } else { completion(.success) }
                                                                                    }
                                                                                }
                                                                            } else { completion(.success) }
                                                                        }
                                                                    }
                                                                } else { completion(.success) }
                                                            }
                                                        }
                                                    } else { completion(.success) }
                                                }
                                            }
                                        } else { completion(.success) }
                                    }
                                }
                            } else { completion(.success) }
                        }
                    }
                } else { completion(.error(.ServiceErrors.Unexpected())) }
            }
        }
    }
}
