//
//  PostCollectionViewCellSummary.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

struct PostCollectionViewCellSummary {
    // MARK: - Properties
    let postType: PostType
    let animalName: String?
    let animalType: AnimalType
    let animalBreed: String
    let animalImages: [UIImage]
    let postImage: UIImage?
    let leadingPadding: CGFloat
    let trailingPadding: CGFloat
}
