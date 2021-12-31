//
//  TabBarViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
  
  // MARK: - Properties
  var viewModel: TabBarViewModel!
  var lastTabBarIndex = 0
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    
    setupBindings()
    viewModel.viewReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    
    let tabBarItems = tabBar.items! as [UITabBarItem]
    
    for (index, _) in tabBarItems.enumerated() {
      setNavigation(index)
    }
    
    self.selectedIndex = TabBarItem.explore.rawValue
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewModel.viewDidAppear()
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
  }
  
  func setNavigation(_ index: Int) {
    guard let nav = viewControllers?[index] as? UINavigationController else { return }
    
    switch TabBarItem(rawValue: index) {
    case .explore:
      nav.viewControllers = [viewModel.didPressExploreTabBarItem()]
    case .profile:
      nav.viewControllers = [viewModel.didPressProfileTabBarItem()]
    default: return
    }
  }
  
  // MARK: - UITabBarControllerDelegate
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    if tabBarController.selectedIndex == TabBarItem.newPost.rawValue {
      tabBarController.selectedIndex = lastTabBarIndex
      viewModel.didPressNewPostTabBarItem()
    } else {
      lastTabBarIndex = tabBarController.selectedIndex
    }
  }
}
