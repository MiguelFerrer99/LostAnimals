//
//  SignUpViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class SignUpViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var progressBarLabel: UILabel!
  @IBOutlet weak var currentProgressBarView: CustomView!
  @IBOutlet weak var fullProgressBarView: CustomView!
  @IBOutlet weak var signupContentsView: CustomView!
  @IBOutlet weak var stepInfoLabel: UILabel!
  @IBOutlet weak var backStepButton: CustomButton!
  @IBOutlet weak var nextStepButton: CustomButton!
  
  // MARK: - Properties
  var viewModel: SignUpViewModel!
  
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
    signupContentsView.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
  
  // MARK: - IBActions
  @IBAction func backStepButtonPressed(_ sender: CustomButton) {
    // TODO: Go to back step
  }
  
  @IBAction func nextStepButtonPressed(_ sender: CustomButton) {
    // TODO: Go to next step
  }
}
