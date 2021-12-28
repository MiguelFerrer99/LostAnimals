//
//  WhereCanWeFindYouViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MapKit

final class WhereCanWeFindYouViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var addressTableView: UITableView!
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "Select your address"
  }
  private var searchController = UISearchController(searchResultsController: nil)
  var searchCompleter = MKLocalSearchCompleter()
  var viewModel: WhereCanWeFindYouViewModel!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupBindings()
    viewModel.viewReady()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewModel.viewDidAppear()
    DispatchQueue.main.async {
      self.searchController.searchBar.becomeFirstResponder()
    }
  }
  
  // MARK: - Functions
  private func setupUI() {
    configureMapKit()
    configureSearchController(searchController)
    configureTableView(addressTableView)
  }
  
  private func setupBindings() {
    // Do bindings setup
  }
}
