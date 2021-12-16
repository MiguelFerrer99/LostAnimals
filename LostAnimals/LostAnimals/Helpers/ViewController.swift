//
//  ViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  var useLargeTitle: Bool {
    return false
  }
  
  var viewDidAppear = false
  
  var hideNavigationBar: Bool {
    return false
  }
  
  var navigationBarTitleColor: UIColor {
    return .customBlack
  }
  
  var navigationBarTintColor: UIColor {
    return .customGreen
  }
  
  var navigationTintColor: UIColor {
    return .customBlack
  }
  
  var navBarTitle: String {
    return ""
  }
  
  var navBarRightButtons: [UIBarButtonItem] {
    return []
  }
  
  var navBarLeftButtons: [UIBarButtonItem] {
    return []
  }
  
  var dismissGestureEnabled: Bool = true {
    willSet {
      self.isModalInPresentation = !newValue
    }
  }
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let titleAttributes = [NSAttributedString.Key.foregroundColor: navigationBarTitleColor, NSAttributedString.Key.font: UIFont.nunitoSmallBold]
    let largeTitleAttributes = [NSAttributedString.Key.font: UIFont.nunitoBigBold]
    
    UINavigationBar.appearance().titleTextAttributes = titleAttributes
    UINavigationBar.appearance().largeTitleTextAttributes = largeTitleAttributes
    UINavigationBar.appearance().tintColor = navigationTintColor
    UINavigationBar.appearance().barTintColor = navigationBarTintColor
    navigationItem.title = navBarTitle
    navigationItem.backButtonTitle = ""
    navigationItem.rightBarButtonItems = navBarRightButtons
    navigationItem.leftBarButtonItems = navBarLeftButtons
    
    NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if useLargeTitle {
      navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    navigationController?.setNavigationBarHidden(hideNavigationBar, animated: false)
    navigationItem.largeTitleDisplayMode = useLargeTitle ? .always : .never
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewDidAppear = true
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Functions
  @objc func didBecomeActive() {
    navigationController?.setNavigationBarHidden(hideNavigationBar, animated: false)
    navigationItem.largeTitleDisplayMode = useLargeTitle ? .always : .never
  }
  
  @objc func keyboardWillShow(notification: NSNotification) { }
  @objc func keyboardWillHide(notification: NSNotification) { }
  
  func hideTabBar() {
    var frame = self.tabBarController?.tabBar.frame
    frame!.origin.y = self.view.frame.size.height + (frame?.size.height)!
    
    self.tabBarController?.tabBar.frame = frame!
    self.tabBarController?.tabBar.isHidden = true
  }
  
  func showTabBar() {
    self.tabBarController?.tabBar.isHidden = false
    var frame = self.tabBarController?.tabBar.frame
    frame!.origin.y = self.view.frame.size.height - (frame?.size.height)!
    self.tabBarController?.tabBar.frame = frame!
  }
}

extension UIViewController {
  var topbarHeight: CGFloat {
    return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
    (self.navigationController?.navigationBar.frame.height ?? 0.0)
  }
  
  private class func getStoryboardName() -> String {
    return "\(self)"
  }
  
  /// Return a viewController instantiated..
  ///
  /// The name of the storyboard needs to be the same as the name of the module, and the the viewController's name needs to be the module's name followed by -Controller.
  /// The storyboardID must be the same as the class name of the viewController.
  ///
  /// - Parameters:
  ///   - viewController: The viewController type to present.
  internal static func instantiate<T: UIViewController>(viewController: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
    
    let storyboardID = viewController.getStoryboardName()
    
    guard let storyboard = UIStoryboard(name: viewController.getStoryboardName(),
                                        bundle: nil).instantiateViewController(withIdentifier: "\(viewController)") as? T else {
      fatalError("ViewController with identifier \(storyboardID), not found in \(viewController) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)") // swiftlint:disable:this line_length
    }
    
    return storyboard
  }
  
  func embeddedInNavigation() -> UINavigationController {
    let navigationVC = UINavigationController(rootViewController: self)
    return navigationVC
  }
  
  func setShadowOn() {
    self.navigationController?.navigationBar.layer.shadowColor = UIColor.darkGray.cgColor
    self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    self.navigationController?.navigationBar.layer.shadowRadius = 4.0
    self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
    self.navigationController?.navigationBar.layer.masksToBounds = false
  }
  
  func setShadowOff() {
    self.navigationController?.navigationBar.layer.shadowColor = UIColor.white.cgColor
    self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    self.navigationController?.navigationBar.layer.shadowOpacity = 0.0
    self.navigationController?.navigationBar.layer.masksToBounds = true
  }
}
