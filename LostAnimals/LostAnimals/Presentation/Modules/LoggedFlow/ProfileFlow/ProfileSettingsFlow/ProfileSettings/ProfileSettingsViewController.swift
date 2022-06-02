//
//  ProfileSettingsViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 25/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ProfileSettingsViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet private weak var blockedUsersView: UIView!
    @IBOutlet private weak var editPersonalDetailsButton: UIButton!
    @IBOutlet private weak var editSocialMediasButton: UIButton!
    @IBOutlet private weak var changePasswordButton: UIButton!
    @IBOutlet private weak var blockedUsersButton: UIButton!
    @IBOutlet private weak var termsAndConditionsButton: UIButton!
    @IBOutlet private weak var deleteAccountButton: UIButton!
    @IBOutlet private weak var logOutButton: UIButton!
    
    // MARK: - Properties
    override var hideNavigationBar: Bool {
        return true
    }
    var viewModel: ProfileSettingsViewModel!
    let imagePickerController = UIImagePickerController()
    
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

// MARK: - Functions
extension ProfileSettingsViewController {
    func removePhoto() {
        switch viewModel.selectedImageView {
        case .user:   break // profileImageView.image = UIImage(named: "DefaultUserImage")
        case .header: break // headerImageView.image = UIImage(named: "DefaultHeaderImage")
        }
    }
    
    func choosePhoto() {
        self.imagePickerController.sourceType = .photoLibrary
        self.present(viewController: imagePickerController, completion: nil)
    }
    
    func takePhoto() {
        self.imagePickerController.sourceType = .camera
        self.present(viewController: imagePickerController, completion: nil)
    }
}

// MARK: - Private functions
private extension ProfileSettingsViewController {
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureImagePickerController()
        fillUI()
    }
    
    func fillUI() {
        // headerImageView.image = viewModel.headerImage
        // profileImageView.image = viewModel.userImage
        // animalShelterImageView.isHidden = !viewModel.me.animalShelter
        blockedUsersView.isHidden = viewModel.me.blockedUsers.isEmpty
    }
    
    func updateUserInteraction() {
        // navigationController?.interactivePopGestureRecognizer?.isEnabled = loadingView.isHidden
        // backButton.isUserInteractionEnabled = loadingView.isHidden
        // changeHeaderImageButton.isUserInteractionEnabled = loadingView.isHidden
        // changeUserImageButton.isUserInteractionEnabled = loadingView.isHidden
        // editPersonalDetailsButton.isUserInteractionEnabled = loadingView.isHidden
        // editSocialMediasButton.isUserInteractionEnabled = loadingView.isHidden
        // changePasswordButton.isUserInteractionEnabled = loadingView.isHidden
        // blockedUsersButton.isUserInteractionEnabled = loadingView.isHidden
        // termsAndConditionsButton.isUserInteractionEnabled = loadingView.isHidden
        // deleteAccountButton.isUserInteractionEnabled = loadingView.isHidden
        // logOutButton.isUserInteractionEnabled = loadingView.isHidden
    }
    
    func showLoading() {
        // loadingView.isHidden = false
        updateUserInteraction()
    }
    
    func hideLoading() {
        // loadingView.isHidden = true
        updateUserInteraction()
    }
}

// MARK: - IBActions
private extension ProfileSettingsViewController {
    @IBAction func editPersonalDataButtonPressed(_ sender: UIButton) {
        viewModel.didPressedEditPersonalDataButton()
    }
    
    @IBAction func editSocialMediasButtonPressed(_ sender: UIButton) {
        viewModel.didPressedEditSocialMediaButton()
    }
    
    @IBAction func changePasswordButtonPressed(_ sender: UIButton) {
        viewModel.didPressedChangePasswordButton()
    }
    
    @IBAction func blockedUsersButtonPressed(_ sender: UIButton) {
        viewModel.didPressedBlockedUsersButton()
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        viewModel.didPressedTermsAndConditionsButton()
    }
    
    @IBAction func deleteAccountButtonPressed(_ sender: UIButton) {
        viewModel.didPressedDeleteAccountButton {
            self.showLoading()
        } completion: {
            self.hideLoading()
        }

    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        viewModel.didPressedLogoutButton {
            self.showLoading()
        } completion: {
            self.hideLoading()
        }

    }
}
