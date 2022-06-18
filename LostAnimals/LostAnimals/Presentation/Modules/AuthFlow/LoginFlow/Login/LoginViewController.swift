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
    @IBOutlet private weak var logInTitleLabel: UILabel!
    @IBOutlet weak var mailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var logInButton: CustomButton!
    
    // MARK: - Properties
    var viewModel: LoginViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fillUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

// MARK: - Private functions
private extension LoginViewController {
    func setupUI() {
        configureTextFields()
        forgotPasswordButton.setTitleColor(.customBlack, for: .disabled)
    }
    
    func fillUI() {
        setLocalizables()
    }
    
    func setLocalizables() {
        logInTitleLabel.text = .LogIn.Title()
        mailTextField.placeholder = .LogIn.Mail()
        passwordTextField.placeholder = .LogIn.Password()
        forgotPasswordButton.setTitle(.LogIn.ForgotPassword(), for: .normal)
        logInButton.setTitle(.LogIn.LogInButton(), for: .normal)
    }
    
    func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = logInButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = logInButton.isEnabled
        mailTextField.isUserInteractionEnabled = logInButton.isEnabled
        passwordTextField.isUserInteractionEnabled = logInButton.isEnabled
        forgotPasswordButton.isUserInteractionEnabled = logInButton.isEnabled
    }
    
    func stopLoadingLogInButton() {
        logInButton.hideLoading {
            self.updateUserInteraction()
        }
    }
}

// MARK: - IBActions
private extension LoginViewController {
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        viewModel.didPressForgotPasswordButton()
    }
    
    @IBAction func logInButtonPressed(_ sender: CustomButton) {
        logInButton.showLoading { self.updateUserInteraction() }
        viewModel.didPressLoginButton(email: mailTextField.value, password: passwordTextField.value) {
            self.stopLoadingLogInButton()
        }
    }
}
