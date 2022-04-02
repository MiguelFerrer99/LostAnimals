//
//  Post.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum AnimalType: String {
    case dog = "Dog"
    case bird = "Bird"
    case cat = "Cat"
    case turtle = "Turtle"
    case snake = "Snake"
    case rabbit = "Rabbit"
    case other = "Other"
}

struct Post {
    // MARK: - Properties
    let id: String
    let postType: PostType
    let animalName: String?
    let animalType: AnimalType
    let animalBreed: String
    let images: [UIImage]
    let lastTimeSeen: String
    let location: Location
    let description: String
    let userID: String
    let saved: Bool
}
