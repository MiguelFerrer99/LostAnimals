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
                    if let user = user {
                        User.shared = user
                        completion(.success)
                    } else {
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
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
                    if let user = user {
                        User.shared = user
                        completion(.success)
                    } else {
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
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
                    if let user = user {
                        User.shared = user
                        completion(.success)
                    } else {
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
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
                    if let user = user {
                        User.shared = user
                        completion(.success)
                    } else {
                        completion(.error(.ServiceErrors.Unexpected()))
                    }
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
                                        if let user = user {
                                            User.shared = user
                                            completion(.success)
                                        } else {
                                            completion(.error(.ServiceErrors.Unexpected()))
                                        }
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
                                if let user = user {
                                    User.shared = user
                                    completion(.success)
                                } else {
                                    completion(.error(.ServiceErrors.Unexpected()))
                                }
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
                                    if let user = user {
                                        User.shared = user
                                        completion(.success)
                                    } else {
                                        completion(.error(.ServiceErrors.Unexpected()))
                                    }
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
                                                    if let user = user {
                                                        User.shared = user
                                                        completion(.success)
                                                    } else {
                                                        completion(.error(.ServiceErrors.Unexpected()))
                                                    }
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
                                                    if let user = user {
                                                        User.shared = user
                                                        completion(.success)
                                                    } else {
                                                        completion(.error(.ServiceErrors.Unexpected()))
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
    
    func deleteMyPet(pet: Pet, completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        self.databaseRef.child("users").child(me.id).child("pet").removeValue { (error, _) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error(.ServiceErrors.InternetConnection()))
                default:
                    completion(.error(.ServiceErrors.Unexpected()))
                }
            } else {
                if pet.urlImage1 != nil {
                    self.storageRef.child("users").child(me.id).child("pet").child("pet_image1").delete { error in
                        if let error = error {
                            switch error.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error(.ServiceErrors.InternetConnection()))
                            default:
                                completion(.error(.ServiceErrors.Unexpected()))
                            }
                        } else {
                            if pet.urlImage2 != nil {
                                self.storageRef.child("users").child(me.id).child("pet").child("pet_image2").delete { error in
                                    if let error = error {
                                        switch error.localizedDescription {
                                        case FirebaseError.networkError.rawValue:
                                            completion(.error(.ServiceErrors.InternetConnection()))
                                        default:
                                            completion(.error(.ServiceErrors.Unexpected()))
                                        }
                                    } else {
                                        if pet.urlImage3 != nil {
                                            self.storageRef.child("users").child(me.id).child("pet").child("pet_image3").delete { error in
                                                if let error = error {
                                                    switch error.localizedDescription {
                                                    case FirebaseError.networkError.rawValue:
                                                        completion(.error(.ServiceErrors.InternetConnection()))
                                                    default:
                                                        completion(.error(.ServiceErrors.Unexpected()))
                                                    }
                                                } else {
                                                    if pet.urlImage4 != nil {
                                                        self.storageRef.child("users").child(me.id).child("pet").child("pet_image4").delete { error in
                                                            if let error = error {
                                                                switch error.localizedDescription {
                                                                case FirebaseError.networkError.rawValue:
                                                                    completion(.error(.ServiceErrors.InternetConnection()))
                                                                default:
                                                                    completion(.error(.ServiceErrors.Unexpected()))
                                                                }
                                                            } else {
                                                                if pet.urlImage5 != nil {
                                                                    self.storageRef.child("users").child(me.id).child("pet").child("pet_image5").delete { error in
                                                                        if let error = error {
                                                                            switch error.localizedDescription {
                                                                            case FirebaseError.networkError.rawValue:
                                                                                completion(.error(.ServiceErrors.InternetConnection()))
                                                                            default:
                                                                                completion(.error(.ServiceErrors.Unexpected()))
                                                                            }
                                                                        } else {
                                                                            if pet.urlImage6 != nil {
                                                                                self.storageRef.child("users").child(me.id).child("pet").child("pet_image6").delete { error in
                                                                                    if let error = error {
                                                                                        switch error.localizedDescription {
                                                                                        case FirebaseError.networkError.rawValue:
                                                                                            completion(.error(.ServiceErrors.InternetConnection()))
                                                                                        default:
                                                                                            completion(.error(.ServiceErrors.Unexpected()))
                                                                                        }
                                                                                    } else {
                                                                                        if pet.urlImage7 != nil {
                                                                                            self.storageRef.child("users").child(me.id).child("pet").child("pet_image7").delete { error in
                                                                                                if let error = error {
                                                                                                    switch error.localizedDescription {
                                                                                                    case FirebaseError.networkError.rawValue:
                                                                                                        completion(.error(.ServiceErrors.InternetConnection()))
                                                                                                    default:
                                                                                                        completion(.error(.ServiceErrors.Unexpected()))
                                                                                                    }
                                                                                                } else {
                                                                                                    if pet.urlImage8 != nil {
                                                                                                        self.storageRef.child("users").child(me.id).child("pet").child("pet_image8").delete { error in
                                                                                                            if let error = error {
                                                                                                                switch error.localizedDescription {
                                                                                                                case FirebaseError.networkError.rawValue:
                                                                                                                    completion(.error(.ServiceErrors.InternetConnection()))
                                                                                                                default:
                                                                                                                    completion(.error(.ServiceErrors.Unexpected()))
                                                                                                                }
                                                                                                            } else {
                                                                                                                self.getMe { user in
                                                                                                                    if let user = user {
                                                                                                                        User.shared = user
                                                                                                                        completion(.success)
                                                                                                                    } else {
                                                                                                                        completion(.error(.ServiceErrors.Unexpected()))
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    } else {
                                                                                                        self.getMe { user in
                                                                                                            if let user = user {
                                                                                                                User.shared = user
                                                                                                                completion(.success)
                                                                                                            } else {
                                                                                                                completion(.error(.ServiceErrors.Unexpected()))
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        } else {
                                                                                            self.getMe { user in
                                                                                                if let user = user {
                                                                                                    User.shared = user
                                                                                                    completion(.success)
                                                                                                } else {
                                                                                                    completion(.error(.ServiceErrors.Unexpected()))
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            } else {
                                                                                self.getMe { user in
                                                                                    if let user = user {
                                                                                        User.shared = user
                                                                                        completion(.success)
                                                                                    } else {
                                                                                        completion(.error(.ServiceErrors.Unexpected()))
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                } else {
                                                                    self.getMe { user in
                                                                        if let user = user {
                                                                            User.shared = user
                                                                            completion(.success)
                                                                        } else {
                                                                            completion(.error(.ServiceErrors.Unexpected()))
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    } else {
                                                        self.getMe { user in
                                                            if let user = user {
                                                                User.shared = user
                                                                completion(.success)
                                                            } else {
                                                                completion(.error(.ServiceErrors.Unexpected()))
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        } else {
                                            self.getMe { user in
                                                if let user = user {
                                                    User.shared = user
                                                    completion(.success)
                                                } else {
                                                    completion(.error(.ServiceErrors.Unexpected()))
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                self.getMe { user in
                                    if let user = user {
                                        User.shared = user
                                        completion(.success)
                                    } else {
                                        completion(.error(.ServiceErrors.Unexpected()))
                                    }
                                }
                            }
                        }
                    }
                } else { completion(.error(.ServiceErrors.Unexpected())) }
            }
        }
    }
    
    func addMyPet(myPet: Pet, images: [UIImage?], completion: @escaping (GenericResult) -> Void) {
        guard let me = User.shared else {
            completion(.error(.ServiceErrors.Unexpected()))
            return
        }
        self.uploadPetImagesAndGetURLs(userID: me.id, images: images) { urlImages in
            do {
                if urlImages.isEmpty { completion(.error(.ServiceErrors.Unexpected())) }
                else {
                    var myNewPet = myPet
                    if let urlImage1 = urlImages[safe: 0] { myNewPet.urlImage1 = urlImage1 }
                    if let urlImage2 = urlImages[safe: 1] { myNewPet.urlImage2 = urlImage2 }
                    if let urlImage3 = urlImages[safe: 2] { myNewPet.urlImage3 = urlImage3 }
                    if let urlImage4 = urlImages[safe: 3] { myNewPet.urlImage4 = urlImage4 }
                    if let urlImage5 = urlImages[safe: 4] { myNewPet.urlImage5 = urlImage5 }
                    if let urlImage6 = urlImages[safe: 5] { myNewPet.urlImage6 = urlImage6 }
                    if let urlImage7 = urlImages[safe: 6] { myNewPet.urlImage7 = urlImage7 }
                    if let urlImage8 = urlImages[safe: 7] { myNewPet.urlImage8 = urlImage8 }
                    let myNewPetDTO = myNewPet.map()
                    let myPetObject = try FirebaseEncoder().encode(myNewPetDTO)
                    self.databaseRef.child("users").child(me.id).child("pet").setValue(myPetObject) { (error, _) in
                        if let error = error {
                            switch error.localizedDescription {
                            case FirebaseError.networkError.rawValue:
                                completion(.error(.ServiceErrors.InternetConnection()))
                            default:
                                completion(.error(.ServiceErrors.Unexpected()))
                            }
                        } else {
                            self.getMe { user in
                                if let user = user {
                                    User.shared = user
                                    completion(.success)
                                } else {
                                    completion(.error(.ServiceErrors.Unexpected()))
                                }
                            }
                        }
                    }
                }
            } catch { completion(.error(.ServiceErrors.Unexpected())) }
        }
    }
}

// MARK: - Private functions
private extension UserService {
    func uploadPetImagesAndGetURLs(userID: String, images: [UIImage?], completion: @escaping (([String?]) -> ())) {
        var urlImages: [String?] = []
        
        if let image1Aux = images[safe: 0], let image1 = image1Aux, let dataImage1 = image1.jpegData(compressionQuality: 0.0) {
            self.storageRef.child("users").child(userID).child("pet").child("pet_image1").putData(dataImage1, metadata: nil) { (_, error) in
                if error == nil {
                    self.storageRef.child("users").child(userID).child("pet").child("pet_image1").downloadURL { (url1, error) in
                        if let url1 = url1, error == nil {
                            urlImages.append(url1.absoluteString)
                            
                            if let image2Aux = images[safe: 1], let image2 = image2Aux, let dataImage2 = image2.jpegData(compressionQuality: 0.0) {
                                self.storageRef.child("users").child(userID).child("pet").child("pet_image2").putData(dataImage2, metadata: nil) { (_, error) in
                                    if error == nil {
                                        self.storageRef.child("users").child(userID).child("pet").child("pet_image2").downloadURL { (url2, error) in
                                            if let url2 = url2, error == nil {
                                                urlImages.append(url2.absoluteString)
                                                
                                                if let image3Aux = images[safe: 2], let image3 = image3Aux, let dataImage3 = image3.jpegData(compressionQuality: 0.0) {
                                                    self.storageRef.child("users").child(userID).child("pet").child("pet_image3").putData(dataImage3, metadata: nil) { (_, error) in
                                                        if error == nil {
                                                            self.storageRef.child("users").child(userID).child("pet").child("pet_image3").downloadURL { (url3, error) in
                                                                if let url3 = url3, error == nil {
                                                                    urlImages.append(url3.absoluteString)
                                                                    
                                                                    if let image4Aux = images[safe: 3], let image4 = image4Aux, let dataImage4 = image4.jpegData(compressionQuality: 0.0) {
                                                                        self.storageRef.child("users").child(userID).child("pet").child("pet_image4").putData(dataImage4, metadata: nil) { (_, error) in
                                                                            if error == nil {
                                                                                self.storageRef.child("users").child(userID).child("pet").child("pet_image4").downloadURL { (url4, error) in
                                                                                    if let url4 = url4, error == nil {
                                                                                        urlImages.append(url4.absoluteString)
                                                                                        
                                                                                        if let image5Aux = images[safe: 4], let image5 = image5Aux, let dataImage5 = image5.jpegData(compressionQuality: 0.0) {
                                                                                            self.storageRef.child("users").child(userID).child("pet").child("pet_image5").putData(dataImage5, metadata: nil) { (_, error) in
                                                                                                if error == nil {
                                                                                                    self.storageRef.child("users").child(userID).child("pet").child("pet_image5").downloadURL { (url5, error) in
                                                                                                        if let url5 = url5, error == nil {
                                                                                                            urlImages.append(url5.absoluteString)
                                                                                                            
                                                                                                            if let image6Aux = images[safe: 5], let image6 = image6Aux, let dataImage6 = image6.jpegData(compressionQuality: 0.0) {
                                                                                                                self.storageRef.child("users").child(userID).child("pet").child("pet_image6").putData(dataImage6, metadata: nil) { (_, error) in
                                                                                                                    if error == nil {
                                                                                                                        self.storageRef.child("users").child(userID).child("pet").child("pet_image6").downloadURL { (url6, error) in
                                                                                                                            if let url6 = url6, error == nil {
                                                                                                                                urlImages.append(url6.absoluteString)
                                                                                                                                
                                                                                                                                if let image7Aux = images[safe: 6], let image7 = image7Aux, let dataImage7 = image7.jpegData(compressionQuality: 0.0) {
                                                                                                                                    self.storageRef.child("users").child(userID).child("pet").child("pet_image7").putData(dataImage7, metadata: nil) { (_, error) in
                                                                                                                                        if error == nil {
                                                                                                                                            self.storageRef.child("users").child(userID).child("pet").child("pet_image7").downloadURL { (url7, error) in
                                                                                                                                                if let url7 = url7, error == nil {
                                                                                                                                                    urlImages.append(url7.absoluteString)
                                                                                                                                                    
                                                                                                                                                    if let image8Aux = images[safe: 7], let image8 = image8Aux, let dataImage8 = image8.jpegData(compressionQuality: 0.0) {
                                                                                                                                                        self.storageRef.child("users").child(userID).child("pet").child("pet_image8").putData(dataImage8, metadata: nil) { (_, error) in
                                                                                                                                                            if error == nil {
                                                                                                                                                                self.storageRef.child("users").child(userID).child("pet").child("pet_image8").downloadURL { (url8, error) in
                                                                                                                                                                    if let url8 = url8 {
                                                                                                                                                                        urlImages.append(url8.absoluteString)
                                                                                                                                                                        completion(urlImages)
                                                                                                                                                                    } else { completion(urlImages) }
                                                                                                                                                                }
                                                                                                                                                            } else { completion(urlImages) }
                                                                                                                                                        }
                                                                                                                                                    } else { completion(urlImages) }
                                                                                                                                                } else { completion(urlImages) }
                                                                                                                                            }
                                                                                                                                        } else { completion(urlImages) }
                                                                                                                                    }
                                                                                                                                } else { completion(urlImages) }
                                                                                                                            } else { completion(urlImages) }
                                                                                                                        }
                                                                                                                    } else { completion(urlImages) }
                                                                                                                }
                                                                                                            } else { completion(urlImages) }
                                                                                                        } else { completion(urlImages) }
                                                                                                    }
                                                                                                } else { completion(urlImages) }
                                                                                            }
                                                                                        } else { completion(urlImages) }
                                                                                    } else { completion(urlImages) }
                                                                                }
                                                                            } else { completion(urlImages) }
                                                                        }
                                                                    } else { completion(urlImages) }
                                                                } else { completion(urlImages) }
                                                            }
                                                        } else { completion(urlImages) }
                                                    }
                                                } else { completion(urlImages) }
                                            } else { completion(urlImages) }
                                        }
                                    } else { completion(urlImages) }
                                }
                            } else { completion(urlImages) }
                        } else { completion(urlImages) }
                    }
                } else { completion(urlImages) }
            }
        } else { completion(urlImages) }
    }
}
