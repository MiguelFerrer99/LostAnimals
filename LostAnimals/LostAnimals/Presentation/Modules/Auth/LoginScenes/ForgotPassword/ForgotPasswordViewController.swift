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
    @IBOutlet private weak var forgotPasswordTitleLabel: UILabel!
    @IBOutlet weak var mailTexfield: CustomTextField!
    @IBOutlet weak var forgotPasswordTextLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: CustomButton!
    
    // MARK: - Properties
    var viewModel: ForgotPasswordViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewReady()
        setupUI()
        fillUI()
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
    
    func fillUI() {
        setLocalizables()
    }
    
    func setLocalizables() {
        forgotPasswordTitleLabel.text = .ForgotPassword.Title()
        mailTexfield.placeholder = .Commons.Mail()
        forgotPasswordTextLabel.text = .ForgotPassword.Text()
        forgotPasswordButton.setTitle(.ForgotPassword.RecoverPasswordButton(), for: .normal)
    }
    
    func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = forgotPasswordButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = forgotPasswordButton.isEnabled
        mailTexfield.isUserInteractionEnabled = forgotPasswordButton.isEnabled
    }
    
    func stopLoadingForgotPasswordButton() {
        forgotPasswordButton.hideLoading {
            self.updateUserInteraction()
        }
    }
}

// MARK: - IBActions
private extension ForgotPasswordViewController {
    @IBAction func recoverPasswordButtonPressed(_ sender: CustomButton) {
        forgotPasswordButton.showLoading { self.updateUserInteraction() }
        viewModel.didPressForgotPasswordButton(email: mailTexfield.value) {
            self.stopLoadingForgotPasswordButton()
        }
    }
}
