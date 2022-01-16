//
//  TermsAndConditionsViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class TermsAndConditionsViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var termsAndConditionsTableView: UITableView!
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "Terms and Conditions"
  }
  var viewModel: TermsAndConditionsViewModel!
  
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
    configureTableView(termsAndConditionsTableView)
  }
}
