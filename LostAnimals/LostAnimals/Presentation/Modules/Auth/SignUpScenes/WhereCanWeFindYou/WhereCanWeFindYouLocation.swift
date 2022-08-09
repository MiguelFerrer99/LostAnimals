//
//  WhereCanWeFindYouLocation.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 18/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import CoreLocation

// MARK: - Functions
extension WhereCanWeFindYouViewController {
    func configureLocationManager(_ locationManager: CLLocationManager) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func getUserCurrentLocation() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .authorized, .authorizedAlways, .authorizedWhenInUse:
                viewModel.loadingLocation = true
                addressTableView.reloadData()
                locationManager.requestLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                finishedGetUserCurrentLocation()
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .authorized, .authorizedAlways, .authorizedWhenInUse:
                viewModel.loadingLocation = true
                addressTableView.reloadData()
                locationManager.requestLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                finishedGetUserCurrentLocation()
            }
        }
    }
    
    func userSharedLocation() -> Bool {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .authorized, .authorizedAlways, .authorizedWhenInUse, .notDetermined: return true
            default: return false
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .authorized, .authorizedAlways, .authorizedWhenInUse, .notDetermined: return true
            default: return false
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension WhereCanWeFindYouViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if !viewModel.locationConfigured {
            viewModel.locationConfigured = true
        } else {
            if #available(iOS 14.0, *) {
                switch manager.authorizationStatus {
                case .authorized, .authorizedAlways, .authorizedWhenInUse:
                    locationManager.requestLocation()
                default:
                    finishedGetUserCurrentLocation()
                }
            } else {
                switch CLLocationManager.authorizationStatus() {
                case .authorized, .authorizedAlways, .authorizedWhenInUse:
                    locationManager.requestLocation()
                default:
                    finishedGetUserCurrentLocation()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let long: Double = manager.location?.coordinate.longitude,
              let lat: Double = manager.location?.coordinate.latitude else { return }
        User.currentCoordinates = Coordinates(longitude: long, latitude: lat)
        finishedGetUserCurrentLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        finishedGetUserCurrentLocation()
    }
}
