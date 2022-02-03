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
        return "Saved posts"
    }
    var refreshControl = UIRefreshControl()
    var viewModel: SavedPostsViewModel!
    
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
        configureCollectionView(savedPostsCollectionView)
        configureRefreshControl(refreshControl)
    }
}
