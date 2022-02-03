//
//  PostCollectionViewCellSummary.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import UIKit

struct PostCollectionViewCellSummary {
    let postType: PostType
    let animal: Animal
    let postImage: UIImage?
    let leadingPadding: CGFloat
    let trailingPadding: CGFloat
}
