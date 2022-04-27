//
//  UserDTO.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - Aditional structs
struct SocialMedias: Codable {
    let phone_prefix: String
    let phone_number: String
    let whatsapp: String?
    let instagram: String?
    let twitter: String?
}

struct UserDTO: Codable {
    // MARK: - Properties
    let id: String
    let email: String
    let animal_shelter: Bool
    let firstname: String
    let lastname: String
    let birthdate: String?
    let user_url_image: String
    let header_url_image: String
    let location: Location
    let social_medias: SocialMedias
    let banned: Bool
    let blocked_users: [String]?
    
    // MARK: - Functions
    func map() -> User {
        var socialMedias: [SocialMediaType: String] = [
            .phonePrefix: social_medias.phone_prefix,
            .phoneNumber: social_medias.phone_number
        ]
        socialMedias[.whatsapp] = social_medias.whatsapp
        socialMedias[.instagram] = social_medias.instagram
        socialMedias[.twitter] = social_medias.twitter
        
        let user = User(id: id,
                        email: email,
                        animalShelter: animal_shelter,
                        firstname: firstname,
                        lastname: lastname,
                        birthdate: birthdate,
                        userURLImage: user_url_image,
                        headerURLImage: header_url_image,
                        location: location,
                        socialMedias: socialMedias,
                        banned: banned,
                        blockedUsers: blocked_users ?? [])
        
        return user
    }
}
