//
//  PetDTO.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation

struct PetDTO: Codable {
    // MARK: - Properties
    let url_image1, url_image2, url_image3, url_image4, url_image5, url_image6, url_image7, url_image8: String?
    let name: String
    let type: String
    let breed: String?
    let description: String?
    
    // MARK: - Functions
    func map() -> Pet? {
        guard let type = AnimalType(rawValue: type.capitalizingFirstLetter()) else { return nil }
        let pet = Pet(urlImage1: url_image1,
                      urlImage2: url_image2,
                      urlImage3: url_image3,
                      urlImage4: url_image4,
                      urlImage5: url_image5,
                      urlImage6: url_image6,
                      urlImage7: url_image7,
                      urlImage8: url_image8,
                      name: name,
                      type: type,
                      breed: breed,
                      description: description)
        return pet
    }
}
