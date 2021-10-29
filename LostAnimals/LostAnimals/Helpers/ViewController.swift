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
  
  var dismissGestureEnabled: Bool = true {
    willSet {
      self.isModalInPresentation = !newValue
    }
  }
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "OpenSans-SemiBold", size: 17) ?? UIFont.systemFont(ofSize: 17) ]
    let largeTitleAttributes = [NSAttributedString.Key.font: UIFont(name: "OpenSans-SemiBold", size: 34) ?? UIFont.boldSystemFont(ofSize: 34)]
    
    UINavigationBar.appearance().titleTextAttributes = titleAttributes
    UINavigationBar.appearance().largeTitleTextAttributes = largeTitleAttributes
    
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
  
  @objc func keyboardWillShow(notification: NSNotification) {}
  @objc func keyboardWillHide(notification: NSNotification) {}
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
}
