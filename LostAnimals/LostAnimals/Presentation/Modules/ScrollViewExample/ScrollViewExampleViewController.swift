//
//  ScrollViewExampleViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ScrollViewExampleViewController: ViewController {
  
  // MARK: - IBOutlets
  
  // MARK: - Properties
  override var hideNavigationBar: Bool {
    return true
  }
  var viewModel: ScrollViewExampleViewModel!
  
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
