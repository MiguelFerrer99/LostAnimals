//
//  LocationFilterPopupLocationManager.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import MapKit
import CoreLocation

// MARK: - Functions
extension LocationFilterPopupViewController {    
    func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = 10.0
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationFilterPopupViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var authorizationStatus: CLAuthorizationStatus = .notDetermined
        if #available(iOS 14.0, *) {
            authorizationStatus = manager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            viewModel.didPressApplyFilterButton()
        case .notDetermined, .restricted, .denied:
            viewModel.didPressDismissButton()
        default: return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        Constants.userCoordinates = Coordinates(longitude: coordinates.longitude, latitude: coordinates.latitude)
        viewModel.didPressApplyFilterButton()
    }
}
