//
//  PostService.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Firebase
import CodableFirebase
import UIKit

// MARK: - Enums
enum UploadPostResult {
    case success
    case error(String)
}

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
            } else if let snapshotValue = snapshot.value {
                do {
                    let postsDTO = try FirebaseDecoder().decode([PostDTO].self, from: snapshotValue)
                    var posts: [Post] = []
                    postsDTO.forEach { if let post = $0.map() { posts.append(post) } }
                    completion(.success(posts))
                } catch { completion(.error("An unexpected error occured. Please, try again later")) }
            }
        }
    }
    
    func uploadPost(post: Post, images: [UIImage?], completion: @escaping (UploadPostResult) -> Void) {
        self.uploadPostImagesAndGetURLs(postID: post.id, images: images) { urlImages in
            do {
                var newPost = post
                newPost.urlImage1 = urlImages[0]
                newPost.urlImage2 = urlImages[1]
                newPost.urlImage3 = urlImages[2]
                newPost.urlImage4 = urlImages[3]
                newPost.urlImage5 = urlImages[4]
                newPost.urlImage6 = urlImages[5]
                newPost.urlImage7 = urlImages[6]
                newPost.urlImage8 = urlImages[7]
                let postObject = try FirebaseEncoder().encode(newPost.map())
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
        
        if let dataImage1 = images[0]?.pngData() {
            self.storageRef.child("posts").child(postID).child("post_image1").putData(dataImage1, metadata: nil) { (_, error) in
                self.storageRef.child("posts").child(postID).child("post_image1").downloadURL { (url1, error) in
                    urlImages.append(url1?.absoluteString)

                    if let dataImage2 = images[1]?.pngData() {
                        self.storageRef.child("posts").child(postID).child("post_image2").putData(dataImage2, metadata: nil) { (_, error) in
                            self.storageRef.child("posts").child(postID).child("post_image2").downloadURL { (url2, error) in
                                urlImages.append(url2?.absoluteString)
                                
                                if let dataImage3 = images[2]?.pngData() {
                                    self.storageRef.child("posts").child(postID).child("post_image3").putData(dataImage3, metadata: nil) { (_, error) in
                                        self.storageRef.child("posts").child(postID).child("post_image3").downloadURL { (url3, error) in
                                            urlImages.append(url3?.absoluteString)
                                            
                                            if let dataImage4 = images[3]?.pngData() {
                                                self.storageRef.child("posts").child(postID).child("post_image4").putData(dataImage4, metadata: nil) { (_, error) in
                                                    self.storageRef.child("posts").child(postID).child("post_image4").downloadURL { (url4, error) in
                                                        urlImages.append(url4?.absoluteString)
                                                        
                                                        if let dataImage5 = images[4]?.pngData() {
                                                            self.storageRef.child("posts").child(postID).child("post_image5").putData(dataImage5, metadata: nil) { (_, error) in
                                                                self.storageRef.child("posts").child(postID).child("post_image5").downloadURL { (url5, error) in
                                                                    urlImages.append(url5?.absoluteString)
                                                                    
                                                                    if let dataImage6 = images[5]?.pngData() {
                                                                        self.storageRef.child("posts").child(postID).child("post_image6").putData(dataImage6, metadata: nil) { (_, error) in
                                                                            self.storageRef.child("posts").child(postID).child("post_image6").downloadURL { (url6, error) in
                                                                                urlImages.append(url6?.absoluteString)
                                                                                
                                                                                if let dataImage7 = images[6]?.pngData() {
                                                                                    self.storageRef.child("posts").child(postID).child("post_image7").putData(dataImage7, metadata: nil) { (_, error) in
                                                                                        self.storageRef.child("posts").child(postID).child("post_image7").downloadURL { (url7, error) in
                                                                                            urlImages.append(url7?.absoluteString)
                                                                                            
                                                                                            if let dataImage8 = images[7]?.pngData() {
                                                                                                self.storageRef.child("posts").child(postID).child("post_image8").putData(dataImage8, metadata: nil) { (_, error) in
                                                                                                    self.storageRef.child("posts").child(postID).child("post_image8").downloadURL { (url8, error) in
                                                                                                        urlImages.append(url8?.absoluteString)
                                                                                                        completion(urlImages)
                                                                                                    }
                                                                                                }
                                                                                            } else { completion(urlImages) }
                                                                                        }
                                                                                    }
                                                                                } else { completion(urlImages) }
                                                                            }
                                                                        }
                                                                    } else { completion(urlImages) }
                                                                }
                                                            }
                                                        } else { completion(urlImages) }
                                                    }
                                                }
                                            } else { completion(urlImages) }
                                        }
                                    }
                                } else { completion(urlImages) }
                            }
                        }
                    } else { completion(urlImages) }
                }
            }
        }
    }
}
