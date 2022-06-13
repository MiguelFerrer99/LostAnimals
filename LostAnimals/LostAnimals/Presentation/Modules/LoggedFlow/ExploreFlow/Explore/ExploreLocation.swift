//
//  ExploreLocation.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import CoreLocation

// MARK: - Functions
extension ExploreViewController {
    func configureLocationManager(_ locationManager: CLLocationManager) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func getUserCurrentLocation() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .authorized, .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
            case .denied:
                finishedGetUserCurrentLocation()
            default:
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .authorized, .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
            case .denied:
                finishedGetUserCurrentLocation()
            default:
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    func userSharedLocation() -> Bool {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .authorized, .authorizedAlways, .authorizedWhenInUse: return true
            default: return false
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .authorized, .authorizedAlways, .authorizedWhenInUse: return true
            default: return false
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension ExploreViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
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
