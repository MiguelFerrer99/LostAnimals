//
//  PostDTO.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

struct PostDTO: Codable {
    // MARK: - Properties
    let id: String
    let post_type: String
    let animal_name: String?
    let animal_type: String
    let animal_breed: String
    let url_image1, url_image2, url_image3, url_image4, url_image5, url_image6, url_image7, url_image8: String?
    let last_time_seen: String
    let location: Location
    let description: String
    let userID: String
    
    // MARK: - Functions
    func map() -> Post? {
        guard let postType = PostType(rawValue: post_type.capitalizingFirstLetter()),
              let animalType = AnimalType(rawValue: animal_type.capitalizingFirstLetter())
        else { return nil }
        
        let post = Post(id: id,
                        postType: postType,
                        animalName: animal_name,
                        animalType: animalType,
                        animalBreed: animal_breed,
                        urlImage1: url_image1,
                        urlImage2: url_image2,
                        urlImage3: url_image3,
                        urlImage4: url_image4,
                        urlImage5: url_image5,
                        urlImage6: url_image6,
                        urlImage7: url_image7,
                        urlImage8: url_image8,
                        lastTimeSeen: last_time_seen,
                        location: location,
                        description: description,
                        userID: userID)
        
        return post
    }
}
