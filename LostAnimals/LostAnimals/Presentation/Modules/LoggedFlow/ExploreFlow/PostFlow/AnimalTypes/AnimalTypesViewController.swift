//
//  AnimalTypesViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalTypesViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var animalTypesTableView: UITableView!
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "Select an animal type"
  }
  var viewModel: AnimalTypesViewModel!
  
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
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
  }
  
  private func setupUI() {
    configureTableView(animalTypesTableView)
  }
}
