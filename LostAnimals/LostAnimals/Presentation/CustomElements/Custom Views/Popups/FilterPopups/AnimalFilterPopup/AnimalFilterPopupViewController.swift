//
//  AnimalFilterPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalFilterPopupViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var animalsFilterTableView: UITableView!
  @IBOutlet weak var applyFilterButton: CustomButton!
  
  // MARK: - Properties
  var viewModel: AnimalFilterPopupViewModel!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    viewModel.viewReady()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewModel.viewDidAppear()
  }
  
  // MARK: - Functions  
  private func setupUI() {
    configureTableView(animalsFilterTableView)
  }
  
  func enableApplyFilterButton() {
    applyFilterButton.alpha = 1
    applyFilterButton.isEnabled = true
  }
  
  func disableApplyFilterButton() {
    applyFilterButton.alpha = 0.5
    applyFilterButton.isEnabled = false
  }
  
  // MARK: - IBActions
  @IBAction func applyFilterButtonPressed(_ sender: CustomButton) {
    viewModel.didPressApplyFilterButton()
  }
  
  @IBAction func dismissButtonPressed(_ sender: Any) {
    viewModel.didPressDismissButton()
  }
}
