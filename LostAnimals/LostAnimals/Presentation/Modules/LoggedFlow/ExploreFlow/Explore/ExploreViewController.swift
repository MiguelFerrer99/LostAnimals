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
        return .Explore.Title()
    }
    override var useLargeTitle: Bool {
        return false
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
        if !userSharedLocation() {
            Filters.currentFilters.removeValue(forKey: .near)
        }
        configureCollectionView(filtersCollectionView)
        selectRecentFilterCell()
        getPosts()
    }
    
    func setNewFilter(_ index: Int) {
        let indexPath = IndexPath(item: FilterType.animal.rawValue, section: 0)
        if let animalFilterCell = filtersCollectionView.cellForItem(at: indexPath) as? ExplorePostsFilterCollectionViewCell {
            animalFilterCell.setFilterTitle("Animal")
        }
        Filters.resetFilters()
        let filterType = FilterType(rawValue: index) ?? .recent
        Filters.currentFilters[filterType]?.enabled = true
        getPosts()
    }
    
    func selectAnimalFilterCell() {
        let indexPath = IndexPath(item: FilterType.animal.rawValue, section: 0)
        filtersCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        if let animalFilterCell = filtersCollectionView.cellForItem(at: indexPath) as? ExplorePostsFilterCollectionViewCell {
            animalFilterCell.setFilterTitle(Filters.currentFilters[.animal]?.animalFiltered?.rawValue ?? "Animal")
        }
        getPosts()
    }
}

// MARK: - Private functions
private extension ExploreViewController {
    func setupUI() {
        subscribeToNotifications()
        currentBarsHeight = self.barHeights
        configureCollectionView(postsCollectionView)
        configureLocationManager(locationManager)
    }
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(getPosts), name: .UpdateExplorePosts, object: nil)
    }
        
    func fillUI() {
        getUserCurrentLocation()
    }
    
    func selectRecentFilterCell() {
        let indexPath = IndexPath(item: FilterType.recent.rawValue, section: 0)
        filtersCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
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
