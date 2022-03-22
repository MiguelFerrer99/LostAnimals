//
//  WhereCanWeFindYouMapkit.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MapKit

// MARK: - Functions
extension WhereCanWeFindYouViewController {
    func configureMapKit() {
        searchCompleter.delegate = self
    }
}

// MARK: - MKLocalSearchCompleterDelegate
extension WhereCanWeFindYouViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        viewModel.searchResults = completer.results
        addressTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
