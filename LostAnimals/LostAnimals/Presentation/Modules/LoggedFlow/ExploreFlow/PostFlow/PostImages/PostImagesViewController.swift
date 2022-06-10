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
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

// MARK: - Functions
extension PostImagesViewController {
    func setupUI() {
        configureCollectionView(postImagesCollectionView)
        scrollToInitItem()
    }
    
    func scrollToInitItem() {
        postImagesCollectionView.performBatchUpdates(nil) { result in
            if result {
                let indexPath = IndexPath(item: self.viewModel.indexPostImage, section: 0)
                self.postImagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }
}

// MARK: - IBActions
private extension PostImagesViewController {
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        viewModel.didPressDismissButton()
    }
}
