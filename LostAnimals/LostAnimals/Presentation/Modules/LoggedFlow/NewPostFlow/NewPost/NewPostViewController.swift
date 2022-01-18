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
  @IBOutlet weak var newPostView: CustomView!
  
  // MARK: - Properties
  override var hideNavigationBar: Bool {
    return true
  }
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
