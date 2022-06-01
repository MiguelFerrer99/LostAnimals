//
//  ProfileViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MessageUI

final class ProfileViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet private weak var profileScrollView: UIScrollView!
    @IBOutlet private weak var backButtonView: UIView!
    @IBOutlet private weak var blockUserButtonImageView: UIImageView!
    @IBOutlet private weak var blockUserButtonView: UIView!
    @IBOutlet private weak var settingsButtonView: UIView!
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var animalShelterImageView: UIImageView!
    @IBOutlet private weak var welcomeBackLabel: UILabel!
    @IBOutlet private weak var basicInfoView: UIView!
    @IBOutlet private weak var basicInfoViewFirstLabel: UILabel!
    @IBOutlet private weak var basicInfoViewSecondLabel: UILabel!
    @IBOutlet private weak var firstStackView: UIStackView!
    @IBOutlet private weak var firstCollectionHeaderLabel: UILabel!
    @IBOutlet private weak var secondStackView: UIStackView!
    @IBOutlet private weak var secondCollectionHeaderLabel: UILabel!
    @IBOutlet private weak var secondCollectionHeaderImageView: UIImageView!
    @IBOutlet private weak var emptyStackView: UIStackView!
    @IBOutlet private weak var emptyLabel: UILabel!
    @IBOutlet private weak var blockedUserView: UIView!
    @IBOutlet private weak var blockedUserLabel: UILabel!
    @IBOutlet private weak var loadingStackView: UIStackView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return viewModel.isMyProfile ? "My profile" : "\(viewModel.user.firstname) \(viewModel.user.lastname)"
    }
    override var hideBackButton: Bool {
        return viewModel.isMyProfile
    }
    override var hideNavigationBar: Bool {
        return shouldHideNavigationBar
    }
    var shouldHideNavigationBar: Bool {
        return profileScrollView.contentOffset.y < 20
    }
    var viewModel: ProfileViewModel!
    var blockUserBarButtonItem = UIBarButtonItem()
    var profileSettingsBarButtonItem = UIBarButtonItem()
    let mailController = MFMailComposeViewController()
    
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

// MARK: - Private functions
private extension ProfileViewController {
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setNavBarButtons()
        configureScrollView(profileScrollView)
        configureCollectionView(firstCollectionView)
        configureCollectionView(secondCollectionView)
        if !viewModel.isMyProfile { configureMailController(mailController: mailController) }
    }
    
    func setNavBarButtons() {
        let isUserBlocked = User.shared?.blockedUsers.contains(viewModel.user.id) ?? false
        blockUserBarButtonItem = UIBarButtonItem(image: UIImage(named: isUserBlocked ? "UnblockUser" : "BlockUser"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(blockOrUnblockUser))
        profileSettingsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(profileSettingsBarButtonItemPressed))
        self.navigationItem.rightBarButtonItems = viewModel.isMyProfile ? [profileSettingsBarButtonItem] : [blockUserBarButtonItem]
    }
    
    func fillUI() {
        fillUserInfoUI()
        fillUserImagesUI()
        fillPostsInfoUI()
    }
    
    func fillUserInfoUI() {
        backButtonView.isHidden = viewModel.isMyProfile
        blockUserButtonView.isHidden = viewModel.isMyProfile
        settingsButtonView.isHidden = !viewModel.isMyProfile
        animalShelterImageView.isHidden = !viewModel.user.animalShelter
        welcomeBackLabel.text = viewModel.isMyProfile ? "Welcome back, \(viewModel.user.firstname)" : "\(viewModel.user.firstname) \(viewModel.user.lastname)"
        basicInfoView.isHidden = viewModel.isMyProfile
        basicInfoViewFirstLabel.isHidden = viewModel.user.animalShelter
        if let age = viewModel.getAge() { basicInfoViewFirstLabel.text = "\(age) years old" }
        basicInfoViewSecondLabel.text = viewModel.user.location.address
        firstCollectionHeaderLabel.text = viewModel.isMyProfile ? "My posts" : "Posts"
        secondCollectionHeaderLabel.text = viewModel.isMyProfile ? "My saved posts" : "Social medias"
        secondCollectionHeaderImageView.isHidden = !viewModel.isMyProfile
        blockedUserLabel.text = "\(viewModel.user.firstname) has been blocked by you"
        let isUserBlocked = User.shared?.blockedUsers.contains(viewModel.user.id) ?? false
        blockUserButtonImageView.image = UIImage(named: isUserBlocked ? "UnblockUserWhite" : "BlockUserWhite")
        basicInfoView.isHidden = isUserBlocked
        firstStackView.isHidden = isUserBlocked
        secondStackView.isHidden = isUserBlocked
        blockedUserView.isHidden = !isUserBlocked
    }
    
    func fillUserImagesUI() {
        if let userURLImage = viewModel.user.userURLImage {
            userURLImage.getURLImage { image in
                if let image = image { self.userImageView.image = image }
            }
        }
        if let headerURLImage = viewModel.user.headerURLImage {
            headerURLImage.getURLImage { image in
                if let image = image { self.headerImageView.image = image }
            }
        }
    }
    
    func fillPostsInfoUI() {
        loadingIndicator.startAnimating()
        loadingStackView.isHidden = false
        viewModel.getPosts {
            if self.viewModel.isMyProfile {
                self.viewModel.getSavedPosts {
                    self.firstCollectionView.reloadData()
                    self.secondCollectionView.reloadData()
                    self.loadingStackView.isHidden = true
                    self.loadingIndicator.startAnimating()
                    self.firstCollectionHeaderLabel.isHidden = self.viewModel.posts.isEmpty
                    self.firstStackView.isHidden = self.viewModel.posts.isEmpty
                    self.secondCollectionHeaderLabel.isHidden = self.viewModel.savedPosts.isEmpty
                    self.secondStackView.isHidden = self.viewModel.savedPosts.isEmpty
                    self.emptyStackView.isHidden = !(self.viewModel.posts.isEmpty && self.viewModel.savedPosts.isEmpty)
                }
            } else {
                self.firstCollectionView.reloadData()
                self.loadingStackView.isHidden = true
                self.loadingIndicator.stopAnimating()
                self.firstCollectionHeaderLabel.isHidden = self.viewModel.posts.isEmpty
                self.firstStackView.isHidden = self.viewModel.posts.isEmpty
            }
        }
    }
    
    func updateBlockedUserUI(isBlocked: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.blockUserBarButtonItem.image = UIImage(named: isBlocked ? "UnblockUser" : "BlockUser")
            self.blockUserButtonImageView.image = UIImage(named: isBlocked ? "UnblockUserWhite" : "BlockUserWhite")
            self.basicInfoView.isHidden = isBlocked
            self.firstStackView.isHidden = isBlocked
            self.secondStackView.isHidden = isBlocked
            self.blockedUserView.isHidden = !isBlocked
        }
    }
    
    @objc func blockOrUnblockUser() {
        viewModel.didPressBlockUserButton { isBlocked in
            self.updateBlockedUserUI(isBlocked: isBlocked)
            if isBlocked { showSuccessPopup(title: "The user has been blocked successfully") }
        }
    }
    
    @objc func profileSettingsBarButtonItemPressed() {
        viewModel.didPressSettingsButton()
    }
}

// MARK: - IBActions
private extension ProfileViewController {
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.didPressBackButton()
    }
    
    @IBAction func blockUserButtonPressed(_ sender: UIButton) {
        blockOrUnblockUser()
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        viewModel.didPressSettingsButton()
    }
    
    @IBAction func headerImagePressed(_ sender: UITapGestureRecognizer) {
        guard let headerImage = headerImageView.image else { return }
        viewModel.didPressHeaderImage(headerImage: headerImage)
    }
    
    @IBAction func userImagePressed(_ sender: UITapGestureRecognizer) {
        guard let userImage = userImageView.image else { return }
        viewModel.didPressUserImage(userImage: userImage)
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        viewModel.didPressLocation()
    }
    
    @IBAction func firstCollectionHeaderButtonPressed(_ sender: UIButton) {
        viewModel.didPressFirstCollectionHeaderButton()
    }
    
    @IBAction func secondCollectionHeaderButtonPressed(_ sender: UIButton) {
        viewModel.didPressSecondCollectionHeaderButton()
    }
}
