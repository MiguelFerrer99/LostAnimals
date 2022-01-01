//
//  PostCollectionViewCellSummary.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

struct PostCollectionViewCellSummary: Hashable {
  let postType: PostType
  let animalName: String
  let animalType: AnimalType
  let postImage: UIImage?
}
