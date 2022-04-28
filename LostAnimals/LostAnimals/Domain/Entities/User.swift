//
//  User.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - Enums
enum SocialMediaType: String {
    case email
    case phonePrefix
    case phoneNumber
    case whatsapp
    case instagram
    case twitter
}

struct User: Equatable {
    // MARK: - Singleton
    static var shared: User?
    
    // MARK: - Properties
    var id: String
    var email: String
    var animalShelter: Bool
    var firstname: String
    var lastname: String
    var birthdate: String?
    let userURLImage: String?
    let headerURLImage: String?
    var location: Location
    var socialMedias: [SocialMediaType: String]
    var banned: Bool
    let blockedUsers: [String]
    let savedPosts: [String]
    
    // MARK: - Functions
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    func map() -> UserDTO? {
        guard let phonePrefix = socialMedias[.phonePrefix],
              let phoneNumber = socialMedias[.phoneNumber]
        else { return nil }
        
        let socialMedias = SocialMedias(phone_prefix: phonePrefix,
                                        phone_number: phoneNumber,
                                        whatsapp: socialMedias[.whatsapp],
                                        instagram: socialMedias[.instagram],
                                        twitter: socialMedias[.twitter])
        
        let userDTO = UserDTO(id: id,
                              email: email,
                              animal_shelter: animalShelter,
                              firstname: firstname,
                              lastname: lastname,
                              birthdate: birthdate,
                              user_url_image: userURLImage,
                              header_url_image: userURLImage,
                              location: location,
                              social_medias: socialMedias,
                              banned: banned,
                              blocked_users: blockedUsers,
                              saved_posts: savedPosts)
        return userDTO
    }
}
