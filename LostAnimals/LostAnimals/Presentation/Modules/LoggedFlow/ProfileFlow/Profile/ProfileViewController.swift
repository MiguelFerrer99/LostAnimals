//
//  ProfileViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 30/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ProfileViewController: ViewController {
  
  // MARK: - IBOutlets
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "My profile"
  }
  override var hideNavigationBar: Bool {
    return true
  }
  override var hideBackButton: Bool {
    return viewModel.isMyProfile
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
    // Do UI setup
  }
  
  // MARK: - IBActions
  @IBAction func logoutButtonPressed(_ sender: CustomButton) {
    viewModel.didPressLogoutButton()
  }
}
