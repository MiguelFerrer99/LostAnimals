//
//  ForgotPasswordViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ForgotPasswordViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var mailTexfield: CustomTextField!
    @IBOutlet weak var forgotPasswordButton: CustomButton!
    
    // MARK: - Properties
    var viewModel: ForgotPasswordViewModel!
    
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
}

private extension ForgotPasswordViewController {
    func setupUI() {
        configureTextFields()
    }
    
    func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = forgotPasswordButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = forgotPasswordButton.isEnabled
        mailTexfield.isUserInteractionEnabled = forgotPasswordButton.isEnabled
    }
    
    func stopLoadingForgotPasswordButton() {
        forgotPasswordButton.hideLoading()
        updateUserInteraction()
    }
}

// MARK: - IBActions
private extension ForgotPasswordViewController {
    @IBAction func recoverPasswordButtonPressed(_ sender: CustomButton) {
        guard let email = mailTexfield.textField.text else { return }
        forgotPasswordButton.showLoading()
        updateUserInteraction()
        viewModel.didPressForgotPasswordButton(email: email) {
            self.stopLoadingForgotPasswordButton()
        }
    }
}
