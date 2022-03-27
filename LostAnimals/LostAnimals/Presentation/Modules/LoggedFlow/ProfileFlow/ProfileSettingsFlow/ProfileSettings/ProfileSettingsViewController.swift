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
    @IBOutlet private weak var changeHeaderImageView: UIView!
    @IBOutlet private weak var changeProfileImageView: CustomView!
    @IBOutlet private weak var animalShelterImageView: UIImageView!
    @IBOutlet private weak var blockedUsersView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var loadingView: CustomView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var changeHeaderImageButton: UIButton!
    @IBOutlet weak var changeUserImageButton: UIButton!
    @IBOutlet weak var editPersonalDetailsButton: UIButton!
    @IBOutlet weak var editSocialMediasButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var blockedUsersButton: UIButton!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
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
        case .user:   profileImageView.image = UIImage(named: "DefaultUserImage")
        case .header: headerImageView.image = UIImage(named: "DefaultHeaderImage")
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

// MARK: - Functions
private extension ProfileSettingsViewController {
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureImagePickerController()
        fillUI()
    }
    
    func fillUI() {
        headerImageView.image = viewModel.me.headerImage
        profileImageView.image = viewModel.me.userImage
        animalShelterImageView.isHidden = !viewModel.me.animalShelter
        blockedUsersView.isHidden = viewModel.me.blockedUsers.isEmpty
    }
    
    func updateUserInteraction() {
        backButton.isUserInteractionEnabled = loadingView.isHidden
        changeHeaderImageButton.isUserInteractionEnabled = loadingView.isHidden
        changeUserImageButton.isUserInteractionEnabled = loadingView.isHidden
        editPersonalDetailsButton.isUserInteractionEnabled = loadingView.isHidden
        editSocialMediasButton.isUserInteractionEnabled = loadingView.isHidden
        changePasswordButton.isUserInteractionEnabled = loadingView.isHidden
        blockedUsersButton.isUserInteractionEnabled = loadingView.isHidden
        termsAndConditionsButton.isUserInteractionEnabled = loadingView.isHidden
        deleteAccountButton.isUserInteractionEnabled = loadingView.isHidden
        logOutButton.isUserInteractionEnabled = loadingView.isHidden
    }
    
    func showLoading() {
        loadingView.isHidden = false
        updateUserInteraction()
    }
}

// MARK: - IBActions
private extension ProfileSettingsViewController {
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.didPressedBackButton()
    }
    
    @IBAction func changeHeaderImageViewButtonPressed(_ sender: UIButton) {
        viewModel.didPressedChangeHeaderImageButton(headerImage: headerImageView.image ?? UIImage())
    }
    
    @IBAction func changeUserImageViewButtonPressed(_ sender: UIButton) {
        viewModel.didPressedChangeProfileImageButton(profileImage: profileImageView.image ?? UIImage())
    }
    
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
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        viewModel.didPressedLogoutButton {
            self.showLoading()
        }
    }
}
