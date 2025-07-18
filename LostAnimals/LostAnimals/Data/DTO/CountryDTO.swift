//
//  CountryDTO.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

struct CountryDTO: Decodable {
    // MARK: - Properties
    let name_en: String
    let name_es: String
    let dial_code: String
    let code: String
    let cities: [String]
    
    // MARK: - Functions
    func map() -> Country {
        return Country(nameEN: name_en, nameES: name_es, dialCode: dial_code, code: code, cities: cities)
    }
}
