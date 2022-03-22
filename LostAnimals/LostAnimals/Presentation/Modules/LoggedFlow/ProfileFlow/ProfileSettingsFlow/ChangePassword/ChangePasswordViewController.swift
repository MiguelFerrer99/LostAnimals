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
    @IBOutlet weak var passwordTextfield: CustomTextField!
    @IBOutlet weak var confirmPasswordTextfield: CustomTextField!
    @IBOutlet weak var saveChangesButton: CustomButton!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Change password"
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
    }
    
    func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = saveChangesButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = saveChangesButton.isEnabled
        passwordTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        confirmPasswordTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
    }
}

// MARK: - IBActions
private extension ChangePasswordViewController {
    @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
        saveChangesButton.showLoading()
        updateUserInteraction()
        viewModel.didPressedSaveChangesButton()
    }
}
