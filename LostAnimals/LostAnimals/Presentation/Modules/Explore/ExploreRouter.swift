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
  func goToFilterPopup(filterType: ExploreFilterType) {
    let viewController: ViewController!
    
    switch filterType {
    case .animal:
      viewController = Container.shared.animalFilterPopupBuilder().build()
    case .location: return
    case .date: return
    default: return
    }
    
    DispatchQueue.main.async {
      self.viewController?.present(viewController: viewController, completion: nil)
    }
  }
  
  func goToSavedPosts() {
    // TODO: Go to SavedPostsVC
  }
}
