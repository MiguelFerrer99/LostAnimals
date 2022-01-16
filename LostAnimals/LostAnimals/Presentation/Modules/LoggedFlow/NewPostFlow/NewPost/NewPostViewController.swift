//
//  NewPostViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class NewPostViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var newPostView: CustomView!
  
  // MARK: - Properties
  var viewModel: NewPostViewModel!
  
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
    newPostView.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
  
  // MARK: - IBActions
  @IBAction func dismissButtonPressed(_ sender: UIButton) {
    viewModel.didPressDismissButton()
  }
  
  @IBAction func lostButtonPressed(_ sender: UIButton) {
    viewModel.didPressLostButton()
  }
  
  @IBAction func foundButtonPressed(_ sender: UIButton) {
    viewModel.didPressFoundButton()
  }
  
  @IBAction func toAdoptButtonPressed(_ sender: UIButton) {
    viewModel.didPressAdoptButton()
  }
}
