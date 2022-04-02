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
    func uploadPost(post: Post, completion: @escaping (UploadPostResult) -> Void) {
        // 1. Subir fotos de los animales
    }
}

// MARK: - Private functions
private extension PostService {}
