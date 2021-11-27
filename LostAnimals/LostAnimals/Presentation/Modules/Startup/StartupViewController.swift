//
//  StartupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class StartupViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var welcomeView: CustomView!
  
  // MARK: - Properties
  override var hideNavigationBar: Bool {
    return true
  }
  var viewModel: StartupViewModel!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupBindings()
    viewModel.viewReady()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewModel.viewDidAppear()
  }
  
  // MARK: - Functions
  private func setupUI() {
    welcomeView.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
  
  private func setupBindings() {}
  
  // MARK: - IBActions
  @IBAction func continueAsGuestButtonPressed(_ sender: UIButton) {
    // TODO: Go to ExploreViewController
  }
  
  @IBAction func logInButtonPressed(_ sender: CustomButton) {
    viewModel.didPressLoginButton()
  }
  
  @IBAction func signUpButtonPressed(_ sender: CustomButton) {
    // TODO: Go to ExploreViewController
  }
}
