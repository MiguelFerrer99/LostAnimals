//
//  ContactWithPopupRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ContactWithPopupRouter {
  // MARK: - Properties
  private weak var viewController: ViewController?
  
  // MARK: - Init
  required init(viewController: ViewController?) {
    self.viewController = viewController
  }
  
  // MARK: - Functions
  func dismissContactWithPopup() {
    self.viewController?.dismissCurrentView(completion: nil)
  }
  
  func contactByMail() {
    
  }
  
  func contactByPhone() {
    
  }
  
  func contactByWhatsapp() {
    
  }
  
  func contactByInstagram() {
    
  }
  
  func contactByTwitter() {
    
  }
}
