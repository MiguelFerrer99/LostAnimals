//
//  ExploreRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class ExploreRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func goToFilterPopup(filterType: FilterType) {
    let viewController: ViewController!
    
    switch filterType {
    case .animal:
      viewController = Container.shared.animalFilterPopupBuilder().build()
    case .location:
      viewController = Container.shared.locationFilterPopupBuilder().build()
    case .date:
      viewController = Container.shared.dateFilterPopupBuilder().build()
    default: return
    }
    
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToSavedPosts() {
    let viewController = Container.shared.savedPostsBuilder().build()
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
  
  func goToPost(post: Post) {
    let viewController = Container.shared.postBuilder().build(comesFrom: .explore, post: post)
    DispatchQueue.main.async {
      self.viewController?.push(viewController: viewController)
    }
  }
}
