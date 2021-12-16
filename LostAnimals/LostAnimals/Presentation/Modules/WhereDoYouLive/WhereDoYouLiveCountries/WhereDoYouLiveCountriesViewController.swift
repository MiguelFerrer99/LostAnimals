//
//  WhereDoYouLiveCountriesViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCountriesViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var countriesTableView: UITableView!
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "Select your country"
  }
  var viewModel: WhereDoYouLiveCountriesViewModel!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBindings()
    viewModel.viewReady()
    setupUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewModel.viewDidAppear()
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
  }
  
  private func setupUI() {
    viewModel.getCountriesFromCountriesJson {
      configureTableview(countriesTableView)
    }
  }
}
