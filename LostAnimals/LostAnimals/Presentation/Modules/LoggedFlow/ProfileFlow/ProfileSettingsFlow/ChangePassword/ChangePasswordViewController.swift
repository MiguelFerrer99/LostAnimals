//
//  ChangePasswordViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ChangePasswordViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet private weak var passwordTextLabel: UILabel!
    @IBOutlet weak var passwordTextfield: CustomTextField!
    @IBOutlet weak var confirmPasswordTextfield: CustomTextField!
    @IBOutlet weak var saveChangesButton: CustomButton!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return .ProfileSettings.ChangePassword()
    }
    override var navBarLeftButtons: [UIBarButtonItem] {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        return [backButton]
    }
    var viewModel: ChangePasswordViewModel!
    
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
}

// MARK: - Private functions
private extension ChangePasswordViewController {
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureTextFields()
        setLocalizables()
    }
    
    func setLocalizables() {
        passwordTextfield.placeholder = .Commons.Password()
        confirmPasswordTextfield.placeholder = .Commons.ConfirmPassword()
        passwordTextLabel.text = .SignUp.AccountDetails.PasswordRequirement()
        saveChangesButton.setTitle(.Commons.SaveChanges(), for: .normal)
    }
    
    func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = saveChangesButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = saveChangesButton.isEnabled
        passwordTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        confirmPasswordTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
    }
    
    @objc func goBack() {
        viewModel.goBack()
    }
}

// MARK: - IBActions
private extension ChangePasswordViewController {
    @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
        saveChangesButton.showLoading { self.updateUserInteraction() }
        viewModel.didPressedSaveChangesButton(newPassword: confirmPasswordTextfield.value) {
            self.saveChangesButton.hideLoading { self.updateUserInteraction() }
        }
    }
}
