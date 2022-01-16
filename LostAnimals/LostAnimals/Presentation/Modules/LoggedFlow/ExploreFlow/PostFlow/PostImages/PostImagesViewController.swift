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
    configureCollectionView(postImagesCollectionView)
    scrollToInitItem()
  }
  
  private func scrollToInitItem() {
    postImagesCollectionView.performBatchUpdates(nil) { result in
      if result {
        let indexPath = IndexPath(item: self.viewModel.indexPostImage, section: 0)
        self.postImagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
      }
    }
  }
  
  // MARK: - IBActions
  @IBAction func dismissButtonPressed(_ sender: UIButton) {
    viewModel.didPressDismissButton()
  }
  
  @IBAction func didPanDownGestureRecognized(_ sender: UIPanGestureRecognizer) {
    let velocity = sender.velocity(in: view)
    if velocity.y > 500 {
      viewModel.didPressDismissButton()
    }
  }
}
