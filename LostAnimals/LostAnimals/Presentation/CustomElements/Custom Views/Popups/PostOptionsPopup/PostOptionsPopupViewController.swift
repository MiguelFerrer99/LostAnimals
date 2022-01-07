//
//  PostOptionsPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostOptionsPopupViewController: ViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var editPostButtonView: UIView!
  
  // MARK: - Properties
  var viewModel: PostOptionsPopupViewModel!
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    UIView.animate(withDuration: 0.25) {
      self.backgroundView.alpha = 0.6
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    UIView.animate(withDuration: 0.25) {
      self.backgroundView.alpha = 0
    }
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
  }
  
  private func setupUI() {
    editPostButtonView.isHidden = viewModel.comesFrom == .explore
  }
  
  // MARK: - IBActions
  @IBAction func dismissButtonPressed(_ sender: UIButton) {
    viewModel.didPressDismissButton()
  }
  
  @IBAction func editPostButtonPressed(_ sender: UIButton) {
    viewModel.didPressEditPostButton()
  }
  
  @IBAction func reportPostButtonPressed(_ sender: UIButton) {
    viewModel.didPressReportPostButton()
  }
}
