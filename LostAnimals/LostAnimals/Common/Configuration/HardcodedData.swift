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
  static let postAuthor = PostAuthor(name: "Miguel Ferrer Fornali", birthdate: Date(), location: "Valencia, Spain", image: UIImage())
  static let animal = Animal(name: "Pepe", type: .dog, breed: "Labrador")
  static let explorePosts: [Post] = [
    Post(postType: .lost,
         animal: animal,
         postImages: [
           UIImage(named: "DogExample"),
           UIImage(named: "Dog"),
           UIImage(named: "Bird"),
           UIImage(named: "Cat"),
           UIImage(named: "Turtle"),
           nil,
           nil,
           nil
         ],
         lastTimeSeen: Date(),
         address: "Vicente Zaragozá, València, España",
         location: Location(lat: 39.48338275374711, long: -0.3572573733480399),
         description: "Descripción 1",
         author: postAuthor,
         isSaved: false)
  ]
}
