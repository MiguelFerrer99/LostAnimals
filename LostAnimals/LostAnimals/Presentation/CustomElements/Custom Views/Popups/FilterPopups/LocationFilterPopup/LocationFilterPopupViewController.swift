//
//  LocationFilterPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class LocationFilterPopupViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var sliderValueLabel: UILabel!
  
  // MARK: - Properties
  var viewModel: LocationFilterPopupViewModel!
  
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
    // Do UI setup
  }
  
  // MARK: - IBActions
  @IBAction func sliderValueChanged(_ sender: UISlider) {
    sliderValueLabel.text = "\(Int(sender.value)) km"
    viewModel.selectedRangeOfKm = Int(sender.value)
  }
  
  @IBAction func dismissButtonPressed(_ sender: UIButton) {
    viewModel.didPressDismissButton()
  }
  
  @IBAction func applyFilterButtonPressed(_ sender: CustomButton) {
    viewModel.didPressApplyFilterButton()
  }
}
