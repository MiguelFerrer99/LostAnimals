//
//  ProfileViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ProfileViewController: ViewController, UIGestureRecognizerDelegate {
  
  // MARK: - IBOutlets
  @IBOutlet weak var backButtonView: UIView!
  @IBOutlet weak var blockUserButtonView: UIView!
  @IBOutlet weak var settingsButtonView: UIView!
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var welcomeBackLabel: UILabel!
  @IBOutlet weak var basicInfoView: UIView!
  @IBOutlet weak var profileCollectionView: UICollectionView!
  
  // MARK: - Properties
  override var hideNavigationBar: Bool {
    return true
  }
  var viewModel: ProfileViewModel!
  
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
    configureCollectionView(profileCollectionView)
    fillUI()
  }
  
  private func fillUI() {
    headerImageView.image = viewModel.user.headerImage
    userImageView.image = viewModel.user.profileImage
    welcomeBackLabel.text = viewModel.isMyProfile ? "Welcome back, \(viewModel.user.firstname)" : "\(viewModel.user.firstname) \(viewModel.user.lastname)"
    backButtonView.isHidden = viewModel.isMyProfile
    blockUserButtonView.isHidden = viewModel.isMyProfile
    settingsButtonView.isHidden = !viewModel.isMyProfile
  }
  
  // MARK: - IBActions
  @IBAction func backButtonPressed(_ sender: UIButton) {
    viewModel.didPressBackButton()
  }
  
  @IBAction func blockUserButtonPressed(_ sender: UIButton) {
    viewModel.didPressBlockUserButton()
  }
  
  @IBAction func logoutButtonPressed(_ sender: CustomButton) {
    viewModel.didPressLogoutButton()
  }
}
