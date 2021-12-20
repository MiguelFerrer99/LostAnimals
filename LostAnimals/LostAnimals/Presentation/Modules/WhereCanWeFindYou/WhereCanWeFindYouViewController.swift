//
//  WhereCanWeFindYouViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 19/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereCanWeFindYouViewController: ViewController {
  
  // MARK: - IBOutlets
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "Select your location"
  }
  var viewModel: WhereCanWeFindYouViewModel!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
}
