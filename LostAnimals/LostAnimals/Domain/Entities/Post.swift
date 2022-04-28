//
//  Post.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - Enums
enum AnimalType: String {
    case dog = "Dog"
    case bird = "Bird"
    case cat = "Cat"
    case turtle = "Turtle"
    case snake = "Snake"
    case rabbit = "Rabbit"
    case other = "Other"
    
    func toDTO() -> String {
        self.rawValue.lowercased()
    }
}

struct Post {
    // MARK: - Properties
    let id: String
    let postType: PostType
    let animalName: String?
    let animalType: AnimalType
    let animalBreed: String
    var urlImage1, urlImage2, urlImage3, urlImage4, urlImage5, urlImage6, urlImage7, urlImage8: String?
    let lastTimeSeen: String
    let location: Location
    let description: String
    let userID: String
    
    // MARK: - Functions
    func map() -> PostDTO {
        let postDTO = PostDTO(id: id,
                              post_type: postType.toDTO(),
                              animal_name: animalName,
                              animal_type: animalType.toDTO(),
                              animal_breed: animalBreed,
                              url_image1: urlImage1,
                              url_image2: urlImage2,
                              url_image3: urlImage3,
                              url_image4: urlImage4,
                              url_image5: urlImage5,
                              url_image6: urlImage6,
                              url_image7: urlImage7,
                              url_image8: urlImage8,
                              last_time_seen: lastTimeSeen,
                              location: location,
                              description: description,
                              user_id: userID)
        return postDTO
    }
}
