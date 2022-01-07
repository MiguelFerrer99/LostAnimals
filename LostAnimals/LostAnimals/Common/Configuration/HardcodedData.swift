//
//  HardcodedData.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

class HardcodedData {
  static let shared = HardcodedData()
}

extension HardcodedData {
  static let postAuthor = PostAuthor(firstname: "Miguel", lastname: "Ferrer Fornali", birthdate: Date(day: 1, month: 3, year: 1999, hour: 0, minute: 0), address: "Valencia, Spain", location: Location(lat: 39.47643457612306, long: -0.3759327513045884), image: UIImage(named: "UserProfilePhotoExample") ?? UIImage())
  static let animal1 = Animal(name: "Pepe", type: .dog, breed: "Labrador")
  static let animal2 = Animal(name: "Benito", type: .cat, breed: "Gato común europeo")
  static let explorePosts: [Post] = [
    Post(postType: .lost,
         animal: animal1,
         postImages: [
           UIImage(named: "DogExample1"),
           UIImage(named: "DogExample2")
         ],
         lastTimeSeen: Date(),
         address: "Vicente Zaragozá, València, España",
         location: Location(lat: 39.48338275374711, long: -0.3572573733480399),
         description: "Descripción 1",
         author: postAuthor,
         isSaved: false),
    Post(postType: .lost,
         animal: animal2,
         postImages: [
           UIImage(named: "CatExample1"),
           UIImage(named: "CatExample2")
         ],
         lastTimeSeen: Date(),
         address: "Vicente Zaragozá, València, España",
         location: Location(lat: 39.48338275374711, long: -0.3572573733480399),
         description: "Descripción 2",
         author: postAuthor,
         isSaved: false)
  ]
}
