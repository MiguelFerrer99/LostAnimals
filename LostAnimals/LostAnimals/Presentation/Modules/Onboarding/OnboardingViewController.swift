//
//  OnboardingViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  // MARK: - Properties
  var viewModel: OnboardingViewModel!
  
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
  
  // MARK: - Actions
}
