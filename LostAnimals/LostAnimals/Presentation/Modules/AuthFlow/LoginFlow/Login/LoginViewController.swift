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
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var logInButton: CustomButton!
    
    // MARK: - Properties
    var viewModel: LoginViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewReady()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
    // MARK: - Functions
    private func setupUI() {
        configureTextFields()
        forgotPasswordButton.setTitleColor(.customBlack, for: .disabled)
    }
    
    private func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = logInButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = logInButton.isEnabled
        mailTextField.isUserInteractionEnabled = logInButton.isEnabled
        passwordTextField.isUserInteractionEnabled = logInButton.isEnabled
        forgotPasswordButton.isUserInteractionEnabled = logInButton.isEnabled
    }
    
    // MARK: - IBActions
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        viewModel.didPressForgotPasswordButton()
    }
    
    @IBAction func logInButtonPressed(_ sender: CustomButton) {
        logInButton.showLoading()
        updateUserInteraction()
        viewModel.didPressLoginButton()
    }
}
