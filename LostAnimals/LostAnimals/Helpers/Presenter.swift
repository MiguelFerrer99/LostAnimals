//
//  Presenter.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

import UIKit

protocol Presenter: AnyObject {
  func present(viewController: UIViewController, completion: (() -> Void)?)
  func presentWithNavBar(viewController: UIViewController, completion: (() -> Void)?)
  func push(viewController: UIViewController)
  func pop()
  func dismissCurrentView(completion: (() -> Void)?)
}

extension UIViewController: Presenter {
  /// Present a UIViewController.
  /// - Parameter viewController: The ViewController to present.
  func present(viewController: UIViewController, completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      self.present(viewController, animated: true, completion: completion)
    }
  }
  
  func presentWithNavBar(viewController: UIViewController, completion: (() -> Void)?) {
    let navigation = UINavigationController(rootViewController: viewController)
    navigation.modalPresentationStyle = .overFullScreen
    present(navigation, animated: true, completion: completion)
  }
  
  /// Push a UIViewController if it has navigation.
  /// - Parameter viewController: The ViewController to push.
  func push(viewController: UIViewController) {
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  func pop() {
    navigationController?.popViewController(animated: true)
  }
  
  /// Dismiss the current presented view.
  func dismissCurrentView(completion: (() -> Void)? = nil) {
    dismiss(animated: true) {
      if let completion = completion { completion() }
    }
  }
}
