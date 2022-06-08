//
//  ViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

// MARK: - Alternative class
class BackBarButtonItem: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        set {}
        get { return super.menu }
    }
}

class ViewController: UIViewController {
    // MARK: - Properties
    var useLargeTitle: Bool {
        return false
    }
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
    var hideBackButton: Bool {
        return false
    }
    var barHeights: CGFloat {
        return getStatusBarHeight() + getNavBarHeight() + getTabBarHeight()
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navBarTitle
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem = BackBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.setHidesBackButton(hideBackButton, animated: true)
        navigationItem.leftBarButtonItems = navBarLeftButtons
        navigationItem.rightBarButtonItems = navBarRightButtons
        
        let titleAttributes = [NSAttributedString.Key.foregroundColor: navigationBarTitleColor, NSAttributedString.Key.font: UIFont.nunitoSmallBold]
        let largeTitleAttributes = [NSAttributedString.Key.foregroundColor: navigationBarTitleColor, NSAttributedString.Key.font: UIFont.nunitoBigBold]
        
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = largeTitleAttributes
        UINavigationBar.appearance().tintColor = navigationTintColor
        UINavigationBar.appearance().barTintColor = navigationBarTintColor
        
        subscribeToNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if useLargeTitle {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        navigationController?.setNavigationBarHidden(hideNavigationBar, animated: true)
        navigationItem.largeTitleDisplayMode = useLargeTitle ? .always : .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit { unsubscribeToNotifications() }
}

// MARK: - Functions
extension ViewController {
    func getStatusBarHeight() -> CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    func getNavBarHeight() -> CGFloat {
        self.navigationController?.navigationBar.frame.size.height ?? 0
    }
    
    func getTabBarHeight() -> CGFloat {
        self.tabBarController?.tabBar.frame.size.height ?? 0
    }
    
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
        var frame = self.tabBarController?.tabBar.frame
        frame!.origin.y = self.view.frame.size.height - (frame?.size.height)!
        self.tabBarController?.tabBar.frame = frame!
    }
    
    func hideTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        frame!.origin.y = self.view.frame.size.height + (frame?.size.height)!
        self.tabBarController?.tabBar.frame = frame!
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func didBecomeActive() {
        navigationController?.setNavigationBarHidden(hideNavigationBar, animated: true)
        navigationItem.largeTitleDisplayMode = useLargeTitle ? .always : .never
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {}
    @objc func keyboardWillHide(notification: NSNotification) {}
}

// MARK: - Private functions
private extension ViewController {
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UIViewController
extension UIViewController {
    // MARK: - Properties
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    // MARK: - Functions
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
    
    /// Present a UIViewController.
    /// - Parameter viewController: The ViewController to present.
    func present(viewController: UIViewController, completion: (() -> Void)? = nil) {
        self.present(viewController, animated: true, completion: completion)
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
