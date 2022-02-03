//
//  LocationViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit
import MapKit

final class LocationViewController: ViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var locationMapView: MKMapView!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Location"
    }
    override var navBarRightButtons: [UIBarButtonItem] {
        let howToGo = UIButton()
        let attributedString = NSAttributedString(string: "How to go?", attributes: [.foregroundColor: UIColor.customBlack])
        howToGo.setAttributedTitle(attributedString, for: .normal)
        howToGo.addTarget(self, action: #selector(howToGoButtonPressed), for: .touchUpInside)
        return [UIBarButtonItem(customView: howToGo)]
    }
    var viewModel: LocationViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
    // MARK: - Functions
    private func setupUI() {
        configureMapView(locationMapView)
    }
}
