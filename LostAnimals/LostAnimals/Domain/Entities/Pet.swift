//
//  Pet.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

struct Pet {
    // MARK: - Properties
    var urlImage1, urlImage2, urlImage3, urlImage4, urlImage5, urlImage6, urlImage7, urlImage8: String?
    let name: String
    let type: AnimalType
    let breed: String?
    let description: String?
    
    // MARK: - Functions
    func map() -> PetDTO {
        let petDTO = PetDTO(url_image1: urlImage1,
                            url_image2: urlImage2,
                            url_image3: urlImage3,
                            url_image4: urlImage4,
                            url_image5: urlImage5,
                            url_image6: urlImage6,
                            url_image7: urlImage7,
                            url_image8: urlImage8,
                            name: name,
                            type: type.toDTO(),
                            breed: breed,
                            description: description)
        return petDTO
    }
}
