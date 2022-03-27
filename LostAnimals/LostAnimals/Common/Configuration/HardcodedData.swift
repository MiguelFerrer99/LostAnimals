//
//  HardcodedData.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

class HardcodedData {
    // MARK: - Singleton
    static let shared = HardcodedData()
}

// MARK: - Properties
extension HardcodedData {
    static let exampleSocialMedias: [SocialMediaType: String] = [.email: "hello@gmail.com",
                                                                 .phonePrefix: "34",
                                                                 .phoneNumber: "000000000",
                                                                 .whatsapp: "+34000000000",
                                                                 .instagram: "instagram",
                                                                 .twitter: "twitter"]
    static let exampleUser1 = User(id: "0",
                                   email: "hello0@gmail.com",
                                   animalShelter: false,
                                   firstname: "Firstname0",
                                   lastname: "Lastname0",
                                   birthdate: "01/01/1999",
                                   userImage: UIImage(named: "DefaultUserImage") ?? UIImage(),
                                   headerImage: UIImage(named: "DefaultHeaderImage") ?? UIImage(),
                                   location: Location(address: "Madrid, España",
                                                      coordinates: Coordinates(longitude: 40.42637089929181, latitude: -3.704263852128349)),
                                   socialMedias: exampleSocialMedias,
                                   banned: false,
                                   blockedUsers: ["1"])
    static let exampleUser2 = User(id: "1",
                                   email: "hello1@gmail.com",
                                   animalShelter: false,
                                   firstname: "Firstname1",
                                   lastname: "Lastname1",
                                   birthdate: "01/01/1999",
                                   userImage: UIImage(named: "DefaultUserImage") ?? UIImage(),
                                   headerImage: UIImage(named: "DefaultHeaderImage") ?? UIImage(),
                                   location: Location(address: "Madrid, España",
                                                      coordinates: Coordinates(longitude: 40.42637089929181, latitude: -3.704263852128349)),
                                   socialMedias: exampleSocialMedias,
                                   banned: false,
                                   blockedUsers: [])
    static let exampleUser3 = User(id: "2",
                                   email: "hello2@gmail.com",
                                   animalShelter: true,
                                   firstname: "Firstname2",
                                   lastname: "",
                                   birthdate: "01/01/1999",
                                   userImage: UIImage(named: "DefaultUserImage") ?? UIImage(),
                                   headerImage: UIImage(named: "DefaultHeaderImage") ?? UIImage(),
                                   location: Location(address: "Madrid, España",
                                                      coordinates: Coordinates(longitude: 40.42637089929181, latitude: -3.704263852128349)),
                                   socialMedias: exampleSocialMedias,
                                   banned: false,
                                   blockedUsers: [])
    static let exampleUsers: [User] = [exampleUser1, exampleUser2, exampleUser3]
    static let exampleAnimal1 = Animal(name: "Animal1", type: .cat, breed: "European common cat", images: [UIImage(named: "CatExample1"), UIImage(named: "CatExample2")])
    static let exampleAnimal2 = Animal(name: nil, type: .dog, breed: "Pitbull", images: [UIImage(named: "DogExample1"), UIImage(named: "DogExample2")])
    static let exampleAnimal3 = Animal(name: "Animal3", type: .bird, breed: "Not specified", images: [UIImage(named: "BirdExample1"), UIImage(named: "BirdExample2")])
    static let post1 = Post(postType: .lost,
                            animal: exampleAnimal1,
                            lastTimeSeen: Date().toString(withFormat: DateFormat.dayMonthYearOther),
                            location: Location(address: "Madrid, España",
                                               coordinates: Coordinates(longitude: 40.42637089929181, latitude: -3.704263852128349)),
                            description: "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas \"Letraset\", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
                            author: exampleUser1,
                            saved: false)
    static let post2 = Post(postType: .found,
                            animal: exampleAnimal2,
                            lastTimeSeen: Date().toString(withFormat: DateFormat.dayMonthYearOther),
                            location: Location(address: "Madrid, España",
                                               coordinates: Coordinates(longitude: 40.42637089929181, latitude: -3.704263852128349)),
                            description: "Not specified",
                            author: exampleUser2,
                            saved: false)
    static let post3 = Post(postType: .adopt,
                            animal: exampleAnimal3,
                            lastTimeSeen: "Not specified",
                            location: Location(address: "Madrid, España",
                                               coordinates: Coordinates(longitude: 40.42637089929181, latitude: -3.704263852128349)),
                            description: "Not specified",
                            author: exampleUser3,
                            saved: false)
    static let explorePosts: [Post] = [post1, post2, post3]
    static let savedPosts: [Post] = [post1, post2, post3]
}
