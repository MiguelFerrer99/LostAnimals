//
//  HardcodedData.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 1/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

class HardcodedData {
  static let shared = HardcodedData()
}

extension HardcodedData {
  static let exampleUser1 = User(id: 0,
                                email: "militardeaire99@gmail.com",
                                firstname: "Miguel",
                                lastname: "Ferrer Fornali",
                                birthdate: "01/03/1999".toDate(withFormat: DateFormat.dayMonthYearOther) ?? Date.today,
                                headerImage: UIImage(named: "ProfileHeaderPlaceholder") ?? UIImage(),
                                profileImage: UIImage(named: "ProfileImagePlaceholder") ?? UIImage(),
                                location: Location(address: "Vega Baixa, 2, Ondara, Alicante, España", coordinates: Coordinates(lat: 38.82358282803209, long: 0.01773679796108817)),
                                isAnimalShelter: false,
                                socialMedias: SocialMedias(email: "militardeaire99@gmail.com", phonePrefix: 34, phoneNumber: 606505059, instagram: "mgl99_", twitter: "mgl99_"),
                                isBanned: false)
  static let exampleUser2 = User(id: 1,
                                email: "joanferrer41@gmail.com",
                                firstname: "Joan",
                                lastname: "Ferrer Fornali",
                                birthdate: "16/10/2000".toDate(withFormat: DateFormat.dayMonthYearOther) ?? Date.today,
                                headerImage: UIImage(named: "ProfileHeaderPlaceholder") ?? UIImage(),
                                profileImage: UIImage(named: "ProfileImagePlaceholder") ?? UIImage(),
                                location: Location(address: "Vega Baixa, 2, Ondara, Alicante, España", coordinates: Coordinates(lat: 38.82358282803209, long: 0.01773679796108817)),
                                isAnimalShelter: false,
                                socialMedias: SocialMedias(email: "joanferrer41@gmail.com", phonePrefix: 34, phoneNumber: 688211592, instagram: "ff.joan_00_", twitter: "Joan_flash"),
                                isBanned: false)
  static let exampleAnimal1 = Animal(name: "Llum", type: .dog, breed: "Labrador", images: [UIImage(named: "DogExample1"), UIImage(named: "DogExample2")])
  static let exampleAnimal2 = Animal(name: "Benito", type: .cat, breed: "Gato común europeo", images: [UIImage(named: "CatExample1"), UIImage(named: "CatExample2")])
  static let explorePosts: [Post] = [
    Post(postType: .lost,
         animal: exampleAnimal1,
         lastTimeSeen: Date(),
         location: Location(address: "Vicente Zaragozá, València, España", coordinates: Coordinates(lat: 39.48338275374711, long: -0.3572573733480399)),
         description: "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas \"Letraset\", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
         author: exampleUser1,
         isSaved: false),
    Post(postType: .lost,
         animal: exampleAnimal2,
         lastTimeSeen: Date(),
         location: Location(address: "Vicente Zaragozá, València, España", coordinates: Coordinates(lat: 39.48338275374711, long: -0.3572573733480399)),
         description: "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas \"Letraset\", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.",
         author: exampleUser2,
         isSaved: false)
  ]
}
