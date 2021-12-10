//
//  WhereDoYouLiveViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  // MARK: - Properties
  var viewModel: WhereDoYouLiveViewModel!
  
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
