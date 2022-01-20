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
  var lastTabBarIndex = TabBarItem.explore.rawValue
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    
    setupUI()
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
  private func setupUI() {
    let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customBlack, NSAttributedString.Key.font: UIFont.nunitoSmallBold]
    let largeTitleAttributes = [NSAttributedString.Key.font: UIFont.nunitoBigBold]
    
    UINavigationBar.appearance().titleTextAttributes = titleAttributes
    UINavigationBar.appearance().largeTitleTextAttributes = largeTitleAttributes
    UINavigationBar.appearance().tintColor = .customBlack
    UINavigationBar.appearance().barTintColor = .customGreen
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
    switch tabBarController.selectedIndex {
    case TabBarItem.explore.rawValue:
      lastTabBarIndex = tabBarController.selectedIndex
    case TabBarItem.newPost.rawValue:
      tabBarController.selectedIndex = lastTabBarIndex
      let logged = Cache.get(boolFor: .logged)
      if logged {
        viewModel.didPressNewPostTabBarItem()
      } else {
        showGuestPopup()
      }
    case TabBarItem.profile.rawValue:
      let logged = Cache.get(boolFor: .logged)
      if logged {
        lastTabBarIndex = tabBarController.selectedIndex
      } else {
        tabBarController.selectedIndex = lastTabBarIndex
        showGuestPopup()
      }
    default: return
    }
  }
}
