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
    let location = CLLocationCoordinate2D(latitude: viewModel.location.lat, longitude: viewModel.location.long)
    let regionRadius = 500.0
    let region = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    mapView.setRegion(region, animated: false)
    
    let annotation = MKPointAnnotation()
    annotation.title = viewModel.animal.name
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
