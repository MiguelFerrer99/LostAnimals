//
//  PostViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostViewController: ViewController {
  
  // MARK: - IBOutlets
  
  // MARK: - Properties
  override var navBarTitle: String {
    switch viewModel.post.postType {
    case .lost:
      return "Lost animal"
    case .found:
      return "Found animal"
    case .adopt:
      return "To adopt animal"
    }
  }
  override var navBarRightButtons: [UIBarButtonItem] {
    let savePost = UIButton()
    savePost.tintColor = .customBlack
    savePost.setImage(UIImage(named: "SavePost"), for: .normal)
    savePost.addTarget(self, action: #selector(savePostButtonPressed), for: .touchUpInside)
    
    let options = UIButton()
    options.tintColor = .customBlack
    options.setImage(UIImage(named: "PostOptions"), for: .normal)
    options.addTarget(self, action: #selector(optionsButtonPressed), for: .touchUpInside)
    
    return [UIBarButtonItem(customView: options), UIBarButtonItem(customView: savePost)]
  }
  var viewModel: PostViewModel!
  
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
    // Do UI setup
  }
  
  @objc private func savePostButtonPressed() {
    viewModel.didPressSavePostButton()
  }
  
  @objc private func optionsButtonPressed() {
    viewModel.didPressOptionsButton()
  }
}
