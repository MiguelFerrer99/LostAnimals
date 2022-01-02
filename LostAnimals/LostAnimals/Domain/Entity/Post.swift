//
//  Post.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

struct Post {
  let postType: PostType
  let animal: Animal
  let postImages: [UIImage]
  let lastTimeSeen: Date
  let location: String
  let description: String
  let author: PostAuthor
  let isSaved: Bool
}
