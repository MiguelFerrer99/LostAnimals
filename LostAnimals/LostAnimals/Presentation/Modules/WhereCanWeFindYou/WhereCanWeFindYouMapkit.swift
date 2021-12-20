//
//  WhereCanWeFindYouMapkit.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MapKit

extension WhereCanWeFindYouViewController: MKLocalSearchCompleterDelegate {
  func configureMapKit() {
    searchCompleter.delegate = self
  }
  
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    viewModel.searchResults = completer.results
    addressTableView.reloadData()
  }
  
  func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    print("Error: \(error.localizedDescription)")
  }
}
