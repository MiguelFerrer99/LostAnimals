//
//  ProfileSettingsViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 25/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol ProfileSettingsDelegate: AnyObject {
    func updateHeaderImage()
    func updateUserImage()
    func updatePersonalDetails()
    func updateSocialMediasDetails()
}

final class ProfileSettingsViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var loadingView: CustomView!
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var editHeaderImageButton: UIButton!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var editUserImageButton: UIButton!
    @IBOutlet private weak var animalShelterImageView: UIImageView!
    @IBOutlet private weak var blockedUsersView: UIView!
    @IBOutlet private weak var editPersonalDetailsButton: UIButton!
    @IBOutlet private weak var editSocialMediasButton: UIButton!
    @IBOutlet private weak var changePasswordButton: UIButton!
    @IBOutlet private weak var blockedUsersButton: UIButton!
    @IBOutlet private weak var termsAndConditionsButton: UIButton!
    @IBOutlet private weak var deleteAccountButton: UIButton!
    @IBOutlet private weak var logOutButton: UIButton!
    @IBOutlet private weak var editPersonalDetailsLabel: UILabel!
    @IBOutlet private weak var editSocialMediaDetailsLabel: UILabel!
    @IBOutlet private weak var changePasswordLabel: UILabel!
    @IBOutlet private weak var blockedUsersLabel: UILabel!
    @IBOutlet private weak var termsAndConditionsLabel: UILabel!
    
    // MARK: - Properties
    override var hideNavigationBar: Bool {
        return true
    }
    var viewModel: ProfileSettingsViewModel!
    let imagePickerController = UIImagePickerController()
    weak var delegate: ProfileSettingsDelegate?
    
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

// MARK: - Functions
extension ProfileSettingsViewController {
    func takePhoto() {
        self.imagePickerController.sourceType = .camera
        self.present(viewController: imagePickerController, completion: nil)
    }
    
    func choosePhoto() {
        self.imagePickerController.sourceType = .photoLibrary
        self.present(viewController: imagePickerController, completion: nil)
    }
    
    func removePhoto() {
        showLoading()
        viewModel.didPressedRemovePhoto { result in
            switch result {
            case .success:
                switch self.viewModel.selectedImageView {
                case .user:
                    self.delegate?.updateUserImage()
                    self.userImageView.image = UIImage(named: "DefaultUserImage")
                    self.viewModel.userImageSelected = false
                case .header:
                    self.delegate?.updateHeaderImage()
                    self.headerImageView.image = UIImage(named: "DefaultHeaderImage")
                    self.viewModel.headerImageSelected = false
                }
                self.hideLoading()
            case .error: self.hideLoading()
            }
        }
    }
    
    func setPhotoFromImagePicker(image: UIImage) {
        showLoading()
        viewModel.didPressedChangePhoto(newImage: image) { result in
            switch result {
            case .success:
                switch self.viewModel.selectedImageView {
                case .user:
                    self.delegate?.updateUserImage()
                    self.userImageView.image = image
                    self.viewModel.userImageSelected = true
                case .header:
                    self.delegate?.updateHeaderImage()
                    self.headerImageView.image = image
                    self.viewModel.headerImageSelected = true
                }
                self.hideLoading()
            case .error: self.hideLoading()
            }
        }
    }
    
    func updateBlockedUsersView() {
        guard let me = User.shared else { return }
        viewModel.me = me
        blockedUsersView.isHidden = viewModel.me.blockedUsers.isEmpty
    }
}

// MARK: - Private functions
private extension ProfileSettingsViewController {
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureImagePickerController()
        setLocalizables()
    }
    
    func setLocalizables() {
        editPersonalDetailsLabel.text = .ProfileSettings.EditPersonalDetials()
        editSocialMediaDetailsLabel.text = .ProfileSettings.EditSocialMediaDetails()
        changePasswordLabel.text = .ProfileSettings.ChangePassword()
        blockedUsersLabel.text = .ProfileSettings.BlockedUsers()
        termsAndConditionsLabel.text = .ProfileSettings.TermsAndConditions()
        deleteAccountButton.setTitle(.ProfileSettings.DeleteAccount(), for: .normal)
        logOutButton.setTitle(.ProfileSettings.LogOut(), for: .normal)
    }
    
    func fillUI() {
        if let headerImage = viewModel.profileImages.headerImage {
            headerImageView.image = headerImage
        }
        if let userImage = viewModel.profileImages.userImage {
            userImageView.image = userImage
        }
        animalShelterImageView.isHidden = !viewModel.me.animalShelter
        updateBlockedUsersView()
    }
    
    func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = loadingView.isHidden
        navigationController?.interactivePopGestureRecognizer?.isEnabled = loadingView.isHidden
        backButton.isUserInteractionEnabled = loadingView.isHidden
        editHeaderImageButton.isUserInteractionEnabled = loadingView.isHidden
        editUserImageButton.isUserInteractionEnabled = loadingView.isHidden
        editPersonalDetailsButton.isUserInteractionEnabled = loadingView.isHidden
        editSocialMediasButton.isUserInteractionEnabled = loadingView.isHidden
        changePasswordButton.isUserInteractionEnabled = loadingView.isHidden
        blockedUsersButton.isUserInteractionEnabled = loadingView.isHidden
        termsAndConditionsButton.isUserInteractionEnabled = loadingView.isHidden
        deleteAccountButton.isUserInteractionEnabled = loadingView.isHidden
        logOutButton.isUserInteractionEnabled = loadingView.isHidden
    }
    
    func showLoading() {
        loadingIndicator.startAnimating()
        loadingView.isHidden = false
        updateUserInteraction()
    }
    
    func hideLoading() {
        loadingView.isHidden = true
        loadingIndicator.stopAnimating()
        updateUserInteraction()
    }
}

// MARK: - IBActions
private extension ProfileSettingsViewController {
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.didPressedBackButton()
    }
    
    @IBAction func editHeaderImageButtonPressed(_ sender: UIButton) {
        guard let currentHeaderImage = headerImageView.image else { return }
        viewModel.didPressedChangeHeaderImageButton(headerImage: currentHeaderImage)
    }
    
    @IBAction func editUserImageButtonPressed(_ sender: UIButton) {
        guard let currentUserImage = userImageView.image else { return }
        viewModel.didPressedChangeProfileImageButton(profileImage: currentUserImage)
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
        viewModel.didPressedDeleteAccountButton()
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        viewModel.didPressedLogoutButton {
            self.showLoading()
        } completion: {
            self.hideLoading()
        }
    }
}
