//
//  HardcodedData.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import  UIKit

class HardcodedData {
  static let shared = HardcodedData()
}

extension HardcodedData {
  static let postAuthor = PostAuthor(name: "Miguel Ferrer Fornali", birthdate: Date(), location: "", image: UIImage())
  static let animal = Animal(name: "Pepe", type: .dog, breed: "Labrador")
  static let explorePosts = [
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false),
    Post(postType: .lost, animal: animal, postImages: [], lastTimeSeen: Date(), location: "", description: "", author: postAuthor, isSaved: false)
  ]
}
