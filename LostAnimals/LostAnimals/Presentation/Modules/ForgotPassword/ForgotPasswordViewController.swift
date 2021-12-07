//
//  ForgotPasswordViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ForgotPasswordViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var mailTexfield: CustomTextField!
  @IBOutlet weak var forgotPasswordButton: CustomButton!
  
  // MARK: - Properties
  var viewModel: ForgotPasswordViewModel!
  
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
    configureTextFields()
  }
  
  private func updateUserInteraction() {
    mailTexfield.isUserInteractionEnabled = forgotPasswordButton.isEnabled
  }
  
  // MARK: - IBActions
  @IBAction func recoverPasswordButtonPressed(_ sender: CustomButton) {
    forgotPasswordButton.showLoading()
    updateUserInteraction()
    viewModel.didPressForgotPasswordButton()
  }
}
