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
    @IBOutlet private weak var loadingView: CustomView!
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

// MARK: - Functions
extension ProfileViewController {
    func reloadHeaderImage() {
        guard let me = User.shared else { return }
        viewModel.user = me
        viewModel.isMyProfile = (me == viewModel.user)
        updateHeaderImageUI()
    }
    
    func reloadUserImage() {
        guard let me = User.shared else { return }
        viewModel.user = me
        viewModel.isMyProfile = (me == viewModel.user)
        updateUserImageUI()
    }
    
    func reloadBasicInfo() {
        guard let me = User.shared else { return }
        viewModel.user = me
        viewModel.isMyProfile = (me == viewModel.user)
        welcomeBackLabel.text = "Welcome back, \(viewModel.user.firstname)"
        basicInfoViewFirstLabel.isHidden = viewModel.user.animalShelter
        if let age = viewModel.getAge() { basicInfoViewFirstLabel.text = "\(age) years old" }
        basicInfoViewSecondLabel.text = viewModel.user.location.address
    }
    
    func reloadSocialMedias() {
        guard let me = User.shared else { return }
        viewModel.user = me
        viewModel.isMyProfile = (me == viewModel.user)
    }
}

// MARK: - Private functions
private extension ProfileViewController {
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setNavBarButtons()
        subscribeToNotifications()
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
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateSavedPosts), name: .UpdateSavedPosts, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMyPosts), name: .UpdateMyPosts, object: nil)
    }
    
    func fillUI() {
        fillUserInfoUI()
        fillUserImagesUI()
        updateBlockedUserUI()
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
    }
    
    func fillUserImagesUI() {
        updateHeaderImageUI()
        updateUserImageUI()
    }
    
    func fillPostsInfoUI() {
        showLoading()
        viewModel.getPosts {
            if self.viewModel.isMyProfile {
                self.viewModel.getSavedPosts {
                    self.firstCollectionView.reloadData()
                    self.firstCollectionHeaderLabel.isHidden = self.viewModel.posts.isEmpty
                    self.firstStackView.isHidden = self.viewModel.posts.isEmpty
                    self.secondCollectionView.reloadData()
                    self.secondCollectionHeaderLabel.isHidden = self.viewModel.savedPosts.isEmpty
                    self.secondStackView.isHidden = self.viewModel.savedPosts.isEmpty
                    self.hideLoading()
                }
            } else {
                self.firstCollectionView.reloadData()
                self.firstCollectionHeaderLabel.isHidden = self.viewModel.posts.isEmpty
                self.firstStackView.isHidden = self.viewModel.posts.isEmpty
                self.secondCollectionView.reloadData()
                self.secondCollectionHeaderLabel.isHidden = false
                self.secondStackView.isHidden = false
                self.hideLoading()
            }
        }
    }
    
    func updateHeaderImageUI() {
        if let headerURLImage = viewModel.user.headerURLImage {
            self.loadingView.isHidden = false
            if viewModel.isMyProfile { self.settingsButtonView.isHidden = true }
            headerURLImage.getURLImage { image in
                if let image = image {
                    self.viewModel.headerImage = image
                    DispatchQueue.main.async {
                        self.loadingView.isHidden = true
                        if self.viewModel.isMyProfile { self.settingsButtonView.isHidden = false }
                        self.headerImageView.image = image
                    }
                }
            }
        } else {
            self.viewModel.headerImage = nil
            self.headerImageView.image = UIImage(named: "DefaultHeaderImage")
        }
    }
    
    func updateUserImageUI() {
        if let userURLImage = viewModel.user.userURLImage {
            self.loadingView.isHidden = false
            if viewModel.isMyProfile { self.settingsButtonView.isHidden = true }
            userURLImage.getURLImage { image in
                if let image = image {
                    self.viewModel.userImage = image
                    DispatchQueue.main.async {
                        self.loadingView.isHidden = true
                        if self.viewModel.isMyProfile { self.settingsButtonView.isHidden = false }
                        self.userImageView.image = image
                    }
                }
            }
        } else {
            self.viewModel.userImage = nil
            self.userImageView.image = UIImage(named: "DefaultUserImage")
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
    
    func updateBlockedUserUI() {
        blockedUserLabel.text = "\(viewModel.user.firstname) has been blocked by you"
        let isUserBlocked = User.shared?.blockedUsers.contains(viewModel.user.id) ?? false
        if isUserBlocked {
            blockUserButtonImageView.image = UIImage(named: "UnblockUserWhite")
        } else {
            blockUserButtonImageView.image = UIImage(named: "BlockUserWhite")
            basicInfoView.isHidden = false
            fillPostsInfoUI()
        }
    }
    
    @objc func updateSavedPosts() {
        showLoading()
        viewModel.getSavedPosts {
            self.secondCollectionView.reloadData()
            self.secondCollectionHeaderLabel.isHidden = self.viewModel.savedPosts.isEmpty
            self.secondStackView.isHidden = self.viewModel.savedPosts.isEmpty
            self.hideLoading()
        }
    }
    
    @objc func updateMyPosts() {
        showLoading()
        viewModel.getPosts {
            self.firstCollectionView.reloadData()
            self.firstCollectionHeaderLabel.isHidden = self.viewModel.posts.isEmpty
            self.firstStackView.isHidden = self.viewModel.posts.isEmpty
            self.hideLoading()
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
    
    func hideLoading() {
        self.loadingStackView.isHidden = true
        self.loadingIndicator.stopAnimating()
    }
    
    func showLoading() {
        self.loadingIndicator.startAnimating()
        self.loadingStackView.isHidden = false
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
