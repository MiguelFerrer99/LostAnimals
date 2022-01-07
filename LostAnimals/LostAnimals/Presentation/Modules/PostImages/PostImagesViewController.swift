//
//  PostImagesViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostImagesViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var postImagesCollectionView: UICollectionView!
  @IBOutlet weak var postImagesPageControl: UIPageControl!
  
  // MARK: - Properties
  var viewModel: PostImagesViewModel!
  
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
}
