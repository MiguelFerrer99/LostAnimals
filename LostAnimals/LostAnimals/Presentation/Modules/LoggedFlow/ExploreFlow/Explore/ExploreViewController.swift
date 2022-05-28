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
    var currentBarsHeight = 0.0
    var viewModel: ExploreViewModel!
    
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
private extension ExploreViewController {
    func setupUI() {
        subscribeToNotifications()
        currentBarsHeight = self.barHeights
        configureCollectionView(postsCollectionView)
    }
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(getPosts), name: .UpdateExplorePosts, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getMeAndGetPosts), name: .UpdateUserAndUpdateExplorePosts, object: nil)
    }
    
    func fillUI() {
        getPosts()
    }
    
    @objc func savedPostsButtonPressed() {
        viewModel.didPressSavedPosts()
    }
}

// MARK: - Functions
extension ExploreViewController {
    @objc func getPosts() {
        viewModel.isLoading = true
        postsCollectionView.reloadData()
        viewModel.getPosts {
            self.viewModel.isLoading = false
            self.postsCollectionView.reloadData()
        }
    }
    
    @objc func getMeAndGetPosts() {
        viewModel.isLoading = true
        postsCollectionView.reloadData()
        viewModel.getMe {
            self.viewModel.getPosts {
                self.viewModel.isLoading = false
                self.postsCollectionView.reloadData()
            }
        }
    }
}
