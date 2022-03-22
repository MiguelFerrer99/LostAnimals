//
//  Post.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

struct Post {
    // MARK: - Properties
    let postType: PostType
    let animal: Animal
    let lastTimeSeen: String
    let location: Location
    let description: String
    let author: User
    let saved: Bool
}
