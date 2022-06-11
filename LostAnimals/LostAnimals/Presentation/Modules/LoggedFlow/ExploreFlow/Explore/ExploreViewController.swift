//
//  ExploreViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import CoreLocation

final class ExploreViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var filtersCollectionView: UICollectionView!
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
    let locationManager = CLLocationManager()
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

// MARK: - Functions
extension ExploreViewController {
    func finishedGetUserCurrentLocation() {
        getPosts()
    }
}

// MARK: - Private functions
private extension ExploreViewController {
    func setupUI() {
        subscribeToNotifications()
        currentBarsHeight = self.barHeights
        configureCollectionView(filtersCollectionView)
        configureCollectionView(postsCollectionView)
        configureLocationManager(locationManager)
    }
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(getPosts), name: .UpdateExplorePosts, object: nil)
    }
    
    func fillUI() {
        getUserCurrentLocation()
    }
    
    @objc func getPosts() {
        viewModel.isLoading = true
        postsCollectionView.reloadData()
        viewModel.getPosts {
            self.viewModel.isLoading = false
            self.postsCollectionView.reloadData()
        }
    }
    
    @objc func savedPostsButtonPressed() {
        viewModel.didPressSavedPosts()
    }
}
