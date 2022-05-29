//
//  SavedPostsViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class SavedPostsViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var savedPostsCollectionView: UICollectionView!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "My saved posts"
    }
    var viewModel: SavedPostsViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewReady()
        setupUI()
        fillUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

// MARK: - Private functions
private extension SavedPostsViewController {
    func setupUI() {
        subscribeToNotifications()
        configureCollectionView(savedPostsCollectionView)
    }
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(getSavedPosts), name: .UpdateSavedPosts, object: nil)
    }
    
    func fillUI() {
        getSavedPosts()
    }
    
    @objc func getSavedPosts() {
        viewModel.isLoading = true
        savedPostsCollectionView.reloadData()
        viewModel.getSavedPosts {
            self.viewModel.isLoading = false
            self.savedPostsCollectionView.reloadData()
        }
    }
}
