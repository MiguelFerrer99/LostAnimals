//
//  ConfirmPasswordViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ConfirmPasswordViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var containerView: CustomView!
    @IBOutlet private weak var confirmPasswordTItleLabel: UILabel!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var deleteAccountButton: CustomButton!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    
    // MARK: - Properties
    override var hideNavigationBar: Bool {
        return true
    }
    var viewModel: ConfirmPasswordViewModel!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.6
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0
        }
    }
}

// MARK: - Private functions
private extension ConfirmPasswordViewController {
    func setupUI() {
        containerView.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        configureTextfields()
        setLocalizables()
    }
    
    func setLocalizables() {
        confirmPasswordTItleLabel.text = .Commons.ConfirmPassword()
        confirmPasswordTextField.placeholder = .Commons.ConfirmPassword()
        deleteAccountButton.setTitle(.ProfileSettings.DeleteAccount(), for: .normal)
    }
    
    func updateUserInteraction() {
        self.backgroundButton.isUserInteractionEnabled = deleteAccountButton.isEnabled
    }
    
    func showLoading() {
        self.deleteAccountButton.showLoading {
            self.updateUserInteraction()
        }
    }
    
    func hideLoading() {
        self.deleteAccountButton.hideLoading {
            self.updateUserInteraction()
        }
    }
}

// MARK: - IBActions
private extension ConfirmPasswordViewController {
    @IBAction func backgroundButtonPressed(_ sender: UIButton) {
        viewModel.didPressDismissButton()
    }
    
    @IBAction func deleteAccountButtonPressed(_ sender: CustomButton) {
        showLoading()
        viewModel.didPressDeleteAccount(password: confirmPasswordTextField.value) {
            self.hideLoading()
        }
    }
}
