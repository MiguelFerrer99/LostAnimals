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
    var refreshControl = UIRefreshControl()
    var viewModel: SavedPostsViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.viewReady()
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
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(getSavedPosts), name: .UpdateExploreSavedPosts, object: nil)
    }
    
    @objc func getSavedPosts() {
        // TODO: - Get Saved Posts
    }
}

// MARK: - Functions
extension SavedPostsViewController {
    func setupUI() {
        subscribeToNotifications()
        Filters.resetFilters()
        configureCollectionView(savedPostsCollectionView)
        configureRefreshControl(refreshControl)
    }
}
