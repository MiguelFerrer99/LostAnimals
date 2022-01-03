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

func showFilterPopup(filterType: FilterType) {
  if topMostController() is UIAlertController { return }
  
  var viewController = ViewController()
  
  switch filterType {
  case .animal:
    viewController = Container.shared.animalFilterPopupBuilder().build()
  case .location: return
  case .date: return
  default: return
  }
  
  topMostController()?.present(viewController: viewController, completion: nil)
}
