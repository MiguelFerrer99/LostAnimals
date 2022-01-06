//
//  SelectPhotoPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SelectPhotoPopupViewController: ViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var removePhotoOptionView: UIView!
  
  // MARK: - Properties
  var viewModel: SelectPhotoPopupViewModel!
  
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
    removePhotoOptionView.isHidden = !viewModel.showRemoveOption
  }
  
  // MARK: - IBActions
  @IBAction func dismissButtonPressed(_ sender: UIButton) {
    viewModel.didPressDismissButton()
  }
  
  @IBAction func removePhotoButtonPressed(_ sender: UIButton) {
    viewModel.didPressRemovePhotoButton()
  }
  
  @IBAction func chooseFromLibraryButtonPressed(_ sender: UIButton) {
    viewModel.didPressChooseFromLibraryButton()
  }
  
  @IBAction func takeAPhotoButtonPressed(_ sender: UIButton) {
    viewModel.didPressTakeAPhotoButton()
  }
}
