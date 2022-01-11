//
//  User.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

struct User: Equatable {
  static func == (lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
  }
  static var shared: User?
  
  let id: Int
  let email: String
  let firstname: String
  let lastname: String
  let birthdate: Date
  let headerImage: UIImage
  let profileImage: UIImage
  let location: Location
  let isAnimalShelter: Bool
  let socialMedias: SocialMedias
  let isBanned: Bool
}
