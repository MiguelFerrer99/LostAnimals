//
//  PostService.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

// MARK: - Enums
enum GetPostsResult {
    case success([Post])
    case error(String)
}

final class PostService {
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
extension PostService {
    func getPosts(completion: @escaping (GetPostsResult) -> Void) {
        databaseRef.child("posts").getData { (error, snapshot) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else if let snapshotValue = snapshot.value as? [String: Any] {
                do {
                    let postsDTO = try FirebaseDecoder().decode([PostDTO].self, from: Array(snapshotValue.values))
                    var posts = postsDTO.compactMap { $0.map() }
                    posts = posts.filter { !(User.shared?.blockedUsers.contains($0.userID) ?? false) }
                    posts.sort { $0.createdAt > $1.createdAt }
                    posts.sort { ($0.distanceToUserLocation ?? 0) < ($1.distanceToUserLocation ?? 0) }
                    completion(.success(posts))
                } catch { completion(.error("An unexpected error occured. Please, try again later")) }
            } else { completion(.success([])) }
        }
    }
    
    func getSavedPosts(completion: @escaping (GetPostsResult) -> Void) {
        databaseRef.child("posts").getData { (error, snapshot) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else if let snapshotValue = snapshot.value as? [String: Any] {
                do {
                    let postsDTO = try FirebaseDecoder().decode([PostDTO].self, from: Array(snapshotValue.values))
                    var posts = postsDTO.compactMap { $0.map() }
                    posts = posts.filter { !(User.shared?.blockedUsers.contains($0.userID) ?? false) }
                    posts = posts.filter { User.shared?.savedPosts.contains($0.id) ?? false }
                    completion(.success(posts))
                } catch { completion(.error("An unexpected error occured. Please, try again later")) }
            } else { completion(.success([])) }
        }
    }
    
    func getMyPosts(completion: @escaping (GetPostsResult) -> Void) {
        databaseRef.child("posts").getData { (error, snapshot) in
            if let error = error {
                switch error.localizedDescription {
                case FirebaseError.networkError.rawValue:
                    completion(.error("You don't have an internet connection"))
                default:
                    completion(.error("An unexpected error occured. Please, try again later"))
                }
            } else if let snapshotValue = snapshot.value as? [String: Any] {
                do {
                    let postsDTO = try FirebaseDecoder().decode([PostDTO].self, from: Array(snapshotValue.values))
                    var posts = postsDTO.compactMap { $0.map() }
                    posts = posts.filter { User.shared?.id == $0.userID }
                    posts.sort { $0.createdAt > $1.createdAt }
                    completion(.success(posts))
                } catch { completion(.error("An unexpected error occured. Please, try again later")) }
            } else { completion(.success([])) }
        }
    }
    
    func uploadPost(post: Post, images: [UIImage?], completion: @escaping (GenericResult) -> Void) {
        self.uploadPostImagesAndGetURLs(postID: post.id, images: images) { urlImages in
            do {
                if urlImages.isEmpty {
                    completion(.error("An unexpected error occured. Please, try again later"))
                } else {
                    var newPost = post
                    if let urlImage1 = urlImages[safe: 0] { newPost.urlImage1 = urlImage1 }
                    if let urlImage2 = urlImages[safe: 1] { newPost.urlImage2 = urlImage2 }
                    if let urlImage3 = urlImages[safe: 2] { newPost.urlImage3 = urlImage3 }
                    if let urlImage4 = urlImages[safe: 3] { newPost.urlImage4 = urlImage4 }
                    if let urlImage5 = urlImages[safe: 4] { newPost.urlImage5 = urlImage5 }
                    if let urlImage6 = urlImages[safe: 5] { newPost.urlImage6 = urlImage6 }
                    if let urlImage7 = urlImages[safe: 6] { newPost.urlImage7 = urlImage7 }
                    if let urlImage8 = urlImages[safe: 7] { newPost.urlImage8 = urlImage8 }
                    let newPostDTO = newPost.map()
                    let postObject = try FirebaseEncoder().encode(newPostDTO)
                    self.databaseRef.child("posts").child(post.id).setValue(postObject) { (error, _) in
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
            } catch {
                completion(.error("An unexpected error occured. Please, try again later"))
            }
        }
    }
}

// MARK: - Private functions
private extension PostService {
    func uploadPostImagesAndGetURLs(postID: String, images: [UIImage?], completion: @escaping (([String?]) -> ())) {
        var urlImages: [String?] = []
        
        if let image1Aux = images[safe: 0], let image1 = image1Aux, let dataImage1 = image1.jpegData(compressionQuality: 0.5) {
            self.storageRef.child("posts").child(postID).child("post_image1").putData(dataImage1, metadata: nil) { (_, error) in
                if error == nil {
                    self.storageRef.child("posts").child(postID).child("post_image1").downloadURL { (url1, error) in
                        if let url1 = url1, error == nil {
                            urlImages.append(url1.absoluteString)
                            
                            if let image2Aux = images[safe: 1], let image2 = image2Aux, let dataImage2 = image2.jpegData(compressionQuality: 0.5) {
                                self.storageRef.child("posts").child(postID).child("post_image2").putData(dataImage2, metadata: nil) { (_, error) in
                                    if error == nil {
                                        self.storageRef.child("posts").child(postID).child("post_image2").downloadURL { (url2, error) in
                                            if let url2 = url2, error == nil {
                                                urlImages.append(url2.absoluteString)
                                                
                                                if let image3Aux = images[safe: 2], let image3 = image3Aux, let dataImage3 = image3.jpegData(compressionQuality: 0.5) {
                                                    self.storageRef.child("posts").child(postID).child("post_image3").putData(dataImage3, metadata: nil) { (_, error) in
                                                        if error == nil {
                                                            self.storageRef.child("posts").child(postID).child("post_image3").downloadURL { (url3, error) in
                                                                if let url3 = url3, error == nil {
                                                                    urlImages.append(url3.absoluteString)
                                                                    
                                                                    if let image4Aux = images[safe: 3], let image4 = image4Aux, let dataImage4 = image4.jpegData(compressionQuality: 0.5) {
                                                                        self.storageRef.child("posts").child(postID).child("post_image4").putData(dataImage4, metadata: nil) { (_, error) in
                                                                            if error == nil {
                                                                                self.storageRef.child("posts").child(postID).child("post_image4").downloadURL { (url4, error) in
                                                                                    if let url4 = url4, error == nil {
                                                                                        urlImages.append(url4.absoluteString)
                                                                                        
                                                                                        if let image5Aux = images[safe: 4], let image5 = image5Aux, let dataImage5 = image5.jpegData(compressionQuality: 0.5) {
                                                                                            self.storageRef.child("posts").child(postID).child("post_image5").putData(dataImage5, metadata: nil) { (_, error) in
                                                                                                if error == nil {
                                                                                                    self.storageRef.child("posts").child(postID).child("post_image5").downloadURL { (url5, error) in
                                                                                                        if let url5 = url5, error == nil {
                                                                                                            urlImages.append(url5.absoluteString)
                                                                                                            
                                                                                                            if let image6Aux = images[safe: 5], let image6 = image6Aux, let dataImage6 = image6.jpegData(compressionQuality: 0.5) {
                                                                                                                self.storageRef.child("posts").child(postID).child("post_image6").putData(dataImage6, metadata: nil) { (_, error) in
                                                                                                                    if error == nil {
                                                                                                                        self.storageRef.child("posts").child(postID).child("post_image6").downloadURL { (url6, error) in
                                                                                                                            if let url6 = url6, error == nil {
                                                                                                                                urlImages.append(url6.absoluteString)
                                                                                                                                
                                                                                                                                if let image7Aux = images[safe: 6], let image7 = image7Aux, let dataImage7 = image7.jpegData(compressionQuality: 0.5) {
                                                                                                                                    self.storageRef.child("posts").child(postID).child("post_image7").putData(dataImage7, metadata: nil) { (_, error) in
                                                                                                                                        if error == nil {
                                                                                                                                            self.storageRef.child("posts").child(postID).child("post_image7").downloadURL { (url7, error) in
                                                                                                                                                if let url7 = url7, error == nil {
                                                                                                                                                    urlImages.append(url7.absoluteString)
                                                                                                                                                    
                                                                                                                                                    if let image8Aux = images[safe: 7], let image8 = image8Aux, let dataImage8 = image8.jpegData(compressionQuality: 0.5) {
                                                                                                                                                        self.storageRef.child("posts").child(postID).child("post_image8").putData(dataImage8, metadata: nil) { (_, error) in
                                                                                                                                                            if error == nil {
                                                                                                                                                                self.storageRef.child("posts").child(postID).child("post_image8").downloadURL { (url8, error) in
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
