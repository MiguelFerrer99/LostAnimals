//
//  WhereCanWeFindYouViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MapKit

// MARK: - Protocols
protocol WhereCanWeFindYouDelegate: AnyObject {
    func getWhereCanWeFindYou(whereCanWeFindYouSearchResult: MKLocalSearchCompletion)
    func getWhereCanWeFindYou(addressString: String)
}

final class WhereCanWeFindYouViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var addressTableView: UITableView!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Select your address"
    }
    private var searchController = UISearchController(searchResultsController: nil)
    weak var delegate: WhereCanWeFindYouDelegate?
    var searchCompleter = MKLocalSearchCompleter()
    let locationManager = CLLocationManager()
    var viewModel: WhereCanWeFindYouViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - Functions
extension WhereCanWeFindYouViewController {
    func finishedGetUserCurrentLocation() {
        if userSharedLocation(), let userCoordinates = User.currentCoordinates {
            getAddressFromCoordinates(userCoordinates) { addressString in
                if let addressString = addressString {
                    self.viewModel.didPressAddress(addressString: addressString, coordinates: userCoordinates)
                } else {
                    showErrorPopup(title: "Sorry, It was not possible to get the address of your location")
                }
            }
        } else { addressTableView.reloadData() }
    }
}

// MARK: - Functions
private extension WhereCanWeFindYouViewController {
    func setupUI() {
        configureMapKit()
        configureLocationManager(locationManager)
        configureSearchController(searchController)
        configureTableView(addressTableView)
    }
}
