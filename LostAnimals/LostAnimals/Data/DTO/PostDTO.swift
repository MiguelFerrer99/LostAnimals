//
//  PostDTO.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

struct PostDTO: Codable {
    // MARK: - Properties
    let id: String
    let post_type: String
    let animal_name: String?
    let animal_type: String
    let animal_breed: String
    let url_images: [String]
    let last_time_seen: String
    let location: Location
    let description: String
    let userID: String
    let saved: Bool
    
    // MARK: - Functions
    func map(completion: @escaping ((Post?) -> ())) {
        guard let postType = PostType(rawValue: post_type.capitalizingFirstLetter()),
              let animalType = AnimalType(rawValue: animal_type.capitalizingFirstLetter())
        else {
            completion(nil)
            return
        }
        
        var images: [UIImage] = []
        url_images.forEach { urlImage in
            urlImage.getURLImage { image in
                if let image = image { images.append(image) }
            }
        }
        
        let post = Post(id: id,
                        postType: postType,
                        animalName: animal_name,
                        animalType: animalType,
                        animalBreed: animal_breed,
                        images: images,
                        lastTimeSeen: last_time_seen,
                        location: location,
                        description: description,
                        userID: userID,
                        saved: saved)
        
        completion(post)
    }
}
