//
//  ProfilePostsViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ProfilePostsViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var profilePostsCollectionView: UICollectionView!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return viewModel.isMyprofile ? "My posts" : "Posts"
    }
    var viewModel: ProfilePostsViewModel!
    
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
private extension ProfilePostsViewController {
    func setupUI() {
        configureCollectionView(profilePostsCollectionView)
    }
}
