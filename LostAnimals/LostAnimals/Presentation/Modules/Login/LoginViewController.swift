//
//  LoginViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class LoginViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var mailTextField: CustomTextField!
  @IBOutlet weak var passwordTextField: CustomTextField!
  
  // MARK: - Properties
  var viewModel: LoginViewModel!
  
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
  
  // MARK: - IBActions
  @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
    // TODO: Go to ForgotPasswordVC
  }
}
