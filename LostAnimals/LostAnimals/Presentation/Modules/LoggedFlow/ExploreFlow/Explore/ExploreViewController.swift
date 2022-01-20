//
//  ExploreViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ExploreViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var postsCollectionView: UICollectionView!
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "Explore"
  }
  override var useLargeTitle: Bool {
    return true
  }
  override var hideBackButton: Bool {
    return true
  }
  override var navBarRightButtons: [UIBarButtonItem] {
    let savedPosts = UIButton()
    savedPosts.tintColor = .customBlack
    savedPosts.setImage(UIImage(named: "SavedPosts"), for: .normal)
    savedPosts.addTarget(self, action: #selector(savedPostsButtonPressed), for: .touchUpInside)
    return [UIBarButtonItem(customView: savedPosts)]
  }
  var refreshControl = UIRefreshControl()
  var viewModel: ExploreViewModel!
  
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
    configureCollectionView(postsCollectionView)
    configureRefreshControl(refreshControl)
  }
  
  @objc private func savedPostsButtonPressed() {
    viewModel.didPressSavedPosts()
  }
}
