//
//  EditPersonalDetailsProtocols.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import MapKit

extension EditPersonalDetailsViewController: WhereCanWeFindYouDelegate {
    func getWhereCanWeFindYou(whereCanWeFindYouSearchResult: MKLocalSearchCompletion) {
        fillWhereCanWeFindYou(searchResult: whereCanWeFindYouSearchResult)
    }
}
