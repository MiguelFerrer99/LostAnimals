//
//  Animal.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

enum AnimalType: String {
    case dog = "Dog"
    case bird = "Bird"
    case cat = "Cat"
    case turtle = "Turtle"
    case snake = "Snake"
    case rabbit = "Rabbit"
    case other = "Other"
}

struct Animal {
    let name: String?
    let type: AnimalType
    let breed: String
    let images: [UIImage?]
}
