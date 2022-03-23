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
}

// MARK: - IBActions
private extension ProfileSettingsViewController {
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.didPressedBackButton()
    }
    
    @IBAction func changeHeaderImageViewButtonPressed(_ sender: UIButton) {
        viewModel.didPressedChangeHeaderImageButton(headerImage: headerImageView.image ?? UIImage())
    }
    
    @IBAction func changeProfileImageViewButtonPressed(_ sender: UIButton) {
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
        viewModel.didPressedDeleteAccountButton()
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        viewModel.didPressedLogoutButton()
    }
}
