//
//  LocationMapView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import MapKit

// MARK: - Functions
extension LocationViewController {
    func configureMapView(_ mapView: MKMapView) {
        mapView.delegate = self
        let location = CLLocationCoordinate2D(latitude: viewModel.coordinates.latitude, longitude: viewModel.coordinates.longitude)
        let regionRadius = 500.0
        let region = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        if let animal = viewModel.animal {
            if let animalName = animal.name {
                annotation.title = animalName
            } else {
                annotation.title = "Found animal"
            }
        } else if let userFirstName = viewModel.userFirstName {
            annotation.title = userFirstName
        }
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        mapView.addAnnotation(annotation)
    }
}

// MARK: - MKMapViewDelegate
extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewModel.openLocationInMaps()
    }
}
