//
//  Window.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

// MARK: - Enums
enum BannedPopupComesFrom: String {
    case login
    case tabbar
}

// MARK: - Properties
let keyWindow       = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
let safeAreaHeight  = keyWindow?.safeAreaLayoutGuide.layoutFrame.height ?? 0
let safeAreaWidth   = keyWindow?.safeAreaLayoutGuide.layoutFrame.width ?? 0
let screenHeight    = keyWindow?.frame.height ?? 0
let screenWidth     = keyWindow?.frame.width ?? 0
let statusBarHeight = keyWindow?.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
let navBarHeight    = keyWindow?.window?.rootViewController?.navigationController?.navigationBar.frame.height ?? 0
let tabBarHeight    = keyWindow?.window?.rootViewController?.tabBarController?.tabBar.frame.height ?? 0

// MARK: - Functions
func topMostController() -> UIViewController? {
    guard let window = keyWindow, let rootViewController = window.rootViewController else { return nil }
    var topController = rootViewController
    while let newTopController = topController.presentedViewController {
        topController = newTopController
    }
    return topController
}

func changeRoot(to viewController: UIViewController) {
    DispatchQueue.main.async {
        let overlayView = UIScreen.main.snapshotView(afterScreenUpdates: false)
        viewController.view.addSubview(overlayView)
        keyWindow?.rootViewController = viewController
        UIView.animate(withDuration: 0.25, delay: 0, options: .transitionCrossDissolve, animations: {
            overlayView.alpha = 0
        }, completion: { _ in
            overlayView.removeFromSuperview()
        })
    }
}

func showAlert(title: String, message: String  = "", completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
        let topMostController = topMostController()
        if topMostController is UIAlertController { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accept = UIAlertAction(title: "Aceptar", style: .default) { _ in
            if let completion = completion { completion() }
        }
        alert.addAction(accept)
        topMostController?.present(viewController: alert)
    }
}

func showGuestPopup() {
    DispatchQueue.main.async {
        let topMostController = topMostController()
        if topMostController is UIAlertController { return }
        let viewController = Container.shared.guestPopupBuilder().build()
        topMostController?.present(viewController: viewController)
    }
}

func showErrorPopup(title: String, action: (() -> Void)? = nil) {
    DispatchQueue.main.async {
        let topMostController = topMostController()
        if topMostController is UIAlertController { return }
        let viewController = Container.shared.errorPopupBuilder().build(errorTitle: title, action: action)
        topMostController?.present(viewController: viewController)
    }
}

func showSuccessPopup(title: String, action: (() -> Void)? = nil) {
    DispatchQueue.main.async {
        let topMostController = topMostController()
        if topMostController is UIAlertController { return }
        let viewController = Container.shared.successPopupBuilder().build(successTitle: title, action: action)
        topMostController?.present(viewController: viewController)
    }
}

func showBannedPopup(comesFrom: BannedPopupComesFrom) {
    DispatchQueue.main.async {
        let topMostController = topMostController()
        if topMostController is UIAlertController { return }
        Cache.logOut()
        let startupViewController = Container.shared.startupBuilder().build().embeddedInNavigation()
        let viewController = Container.shared.errorPopupBuilder().build(errorTitle: "You has been banned of LostAnimals. Please contact with the administrator to solve this situation") {
            if comesFrom != .login { changeRoot(to: startupViewController) }
        }
        topMostController?.present(viewController: viewController)
    }
}

func showConfirmationPopup(title: String, yesAction: (() -> Void)? = nil) {
    DispatchQueue.main.async {
        let topMostController = topMostController()
        if topMostController is UIAlertController { return }
        let viewController = Container.shared.confirmationPopupBuilder().build(title: title, yesAction: yesAction)
        topMostController?.present(viewController: viewController)
    }
}
