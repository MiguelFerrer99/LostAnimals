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
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var blockUserButtonImageView: UIImageView!
    @IBOutlet weak var blockUserButtonView: UIView!
    @IBOutlet weak var settingsButtonView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var animalShelterImageView: UIImageView!
    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var basicInfoViewFirstLabel: UILabel!
    @IBOutlet weak var basicInfoViewSecondLabel: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var firstCollectionHeaderLabel: UILabel!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var secondCollectionHeaderLabel: UILabel!
    @IBOutlet weak var secondCollectionHeaderImageView: UIImageView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    // MARK: - Properties
    override var hideBackButton: Bool {
        return viewModel.isMyProfile
    }
    override var hideNavigationBar: Bool {
        return true
    }
    var viewModel: ProfileViewModel!
    let mailController = MFMailComposeViewController()
    
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
    
    // MARK: - Functions
    private func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureCollectionView(firstCollectionView)
        configureCollectionView(secondCollectionView)
        if !viewModel.isMyProfile {
            configureMailController(mailController: mailController)
        }
        fillUI()
    }
    
    private func fillUI() {
        backButtonView.isHidden = viewModel.isMyProfile
        blockUserButtonView.isHidden = viewModel.isMyProfile
        settingsButtonView.isHidden = !viewModel.isMyProfile
        headerImageView.image = viewModel.user.headerImage
        userImageView.image = viewModel.user.profileImage
        animalShelterImageView.isHidden = !viewModel.user.isAnimalShelter
        welcomeBackLabel.text = viewModel.isMyProfile ? "Welcome back, \(viewModel.user.firstname)" : "\(viewModel.user.firstname) \(viewModel.user.lastname)"
        basicInfoView.isHidden = viewModel.isMyProfile
        basicInfoViewFirstLabel.isHidden = viewModel.user.isAnimalShelter
        if let age = viewModel.getAge() {
            basicInfoViewFirstLabel.text = "\(age) years old"
        }
        basicInfoViewSecondLabel.text = viewModel.user.location.address
        firstCollectionHeaderLabel.text = viewModel.isMyProfile ? "My posts" : "Posts"
        secondCollectionHeaderLabel.text = viewModel.isMyProfile ? "My saved posts" : "Social medias"
        secondCollectionHeaderImageView.isHidden = !viewModel.isMyProfile
    }
    
    private func updateBlockedUserUI() {
        UIView.animate(withDuration: 0.25) {
            self.blockUserButtonImageView.image = UIImage(named: self.viewModel.isBlocked ? "UnblockUserWhite" : "BlockUserWhite")
            self.basicInfoView.isHidden = self.viewModel.isBlocked
            self.firstStackView.isHidden = self.viewModel.isBlocked
            self.secondStackView.isHidden = self.viewModel.isBlocked
        }
    }
    
    private func blockUser() {
        viewModel.didPressBlockUserButton { allowed in
            if allowed { updateBlockedUserUI() }
        }
    }
    
    // MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.didPressBackButton()
    }
    
    @IBAction func blockUserButtonPressed(_ sender: UIButton) {
        blockUser()
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        viewModel.didPressSettingsButton()
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
