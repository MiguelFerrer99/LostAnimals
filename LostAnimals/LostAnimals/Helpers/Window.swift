//
//  Window.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

func topMostController() -> UIViewController? {
  guard let window = keyWindow, let rootViewController = window.rootViewController else {
    return nil
  }
  
  var topController = rootViewController
  
  while let newTopController = topController.presentedViewController {
    topController = newTopController
  }
  
  return topController
}

let keyWindow       = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let safeAreaHeight  = keyWindow?.safeAreaLayoutGuide.layoutFrame.height ?? 0
let safeAreaWidth   = keyWindow?.safeAreaLayoutGuide.layoutFrame.width ?? 0
let screenHeight    = keyWindow?.frame.height ?? 0
let screenWidth     = keyWindow?.frame.width ?? 0

func changeRoot(to viewController: UIViewController) {
  let overlayView = UIScreen.main.snapshotView(afterScreenUpdates: false)
  viewController.view.addSubview(overlayView)
  keyWindow?.rootViewController = viewController
  
  UIView.animate(withDuration: 0.25, delay: 0, options: .transitionCrossDissolve, animations: {
    overlayView.alpha = 0
  }, completion: { _ in 
    overlayView.removeFromSuperview()
  })
}

func showAlert(title: String, message: String  = "", completion: (() -> Void)? = nil) {
  if topMostController() is UIAlertController { return }
  
  let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
  let accept = UIAlertAction(title: "Aceptar", style: .default) { _ in
    if let completion = completion { completion() }
  }
  
  alert.addAction(accept)
  
  topMostController()?.present(viewController: alert)
}

func showGuestPopup() {
  if topMostController() is UIAlertController { return }
  
  let viewController = Container.shared.guestPopupBuilder().build()
  
  DispatchQueue.main.async {
    topMostController()?.present(viewController: viewController)
  }
}

func showErrorPopup(title: String, action: ()? = nil) {
  if topMostController() is UIAlertController { return }
  
  let viewController = Container.shared.errorPopupBuilder().build(errorTitle: title, action: action)
  
  DispatchQueue.main.async {
    topMostController()?.present(viewController: viewController)
  }
}

func showSuccessPopup(title: String, action: ()? = nil) {
  if topMostController() is UIAlertController { return }
  
  let viewController = Container.shared.successPopupBuilder().build(successTitle: title, action: action)
  
  DispatchQueue.main.async {
    topMostController()?.present(viewController: viewController)
  }
}

func showBannedPopup(comesFrom: BannedPopupComesFrom) {
  if topMostController() is UIAlertController { return }
  
  Cache.logOut()
  
  let startupViewController = Container.shared.startupBuilder().build().embeddedInNavigation()
  let viewController = Container.shared.errorPopupBuilder().build(
    errorTitle: "You has been banned of LostAnimals. Please contact with the administrator to solve this situation",
    action: comesFrom == .login ? nil : changeRoot(to: startupViewController))
  
  DispatchQueue.main.async {
    topMostController()?.present(viewController: viewController)
  }
}
