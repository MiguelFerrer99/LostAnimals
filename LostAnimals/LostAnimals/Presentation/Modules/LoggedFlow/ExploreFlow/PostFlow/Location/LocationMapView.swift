//
//  LocationMapView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import MapKit

extension LocationViewController: MKMapViewDelegate {
  // MARK: - Functions
  func configureMapView(_ mapView: MKMapView) {
    mapView.delegate = self
    let location = CLLocationCoordinate2D(latitude: viewModel.coordinates.lat, longitude: viewModel.coordinates.long)
    let regionRadius = 500.0
    let region = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    mapView.setRegion(region, animated: false)
    
    let annotation = MKPointAnnotation()
    if let animalName = viewModel.animalName {
      annotation.title = animalName
    } else if let userFirstName = viewModel.userFirstName {
      annotation.title = userFirstName
    }
    annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    mapView.addAnnotation(annotation)
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    viewModel.openLocationInMaps()
  }
  
  @objc func howToGoButtonPressed() {
    viewModel.openLocationInMaps()
  }
}
