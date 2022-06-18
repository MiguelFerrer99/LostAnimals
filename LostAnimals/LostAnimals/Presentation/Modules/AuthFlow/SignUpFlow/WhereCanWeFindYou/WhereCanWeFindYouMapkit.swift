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
    
    func getAddressFromCoordinates(_ coordinates: Coordinates, completion: @escaping ((String?) -> ())) {
        let geocoder: CLGeocoder = CLGeocoder()
        let location: CLLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemarks = placemarks, !placemarks.isEmpty, error == nil {
                let placemark = placemarks[0]
                var addressString = ""
                if let sublocality = placemark.subLocality {
                    addressString += sublocality  + ", "
                }
                if let thoroughfare = placemark.thoroughfare {
                    addressString += thoroughfare  + ", "
                }
                if let locality = placemark.locality {
                    addressString += locality  + ", "
                }
                if let country = placemark.country {
                    addressString += country  + ", "
                }
                if let postalCode = placemark.postalCode {
                    addressString += postalCode
                }
                completion(addressString)
            } else { completion(nil) }
        }
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
