//
//  WhereDoYouLiveCitiesViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 11/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCitiesViewController: ViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var citiesTableView: UITableView!
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "Select your city"
  }
  var viewModel: WhereDoYouLiveCitiesViewModel!
  
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
    configureTableview(citiesTableView)
  }
}
