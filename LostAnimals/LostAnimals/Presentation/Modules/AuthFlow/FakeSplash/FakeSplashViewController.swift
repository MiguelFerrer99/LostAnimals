//
//  FakeSplashViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class FakeSplashViewController: ViewController {
    // MARK: - IBOutlets
    
    // MARK: - Properties
    var viewModel: FakeSplashViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

// MARK: - Private functions
private extension FakeSplashViewController {
    func setupUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if Cache.get(boolFor: .logged) {
                self.viewModel.getMe { me in
                    if let me = me {
                        User.shared = me
                        if Cache.get(boolFor: .onboardingDone) {
                            self.viewModel.goToTabBar()
                        } else {
                            self.viewModel.goToOnboarding()
                        }
                    } else {
                        Cache.logOut()
                        self.viewModel.goToStartup()
                    }
                }
            } else {
                self.viewModel.goToStartup()
            }
        }
    }
}

// MARK: - Functions
extension FakeSplashViewController {}

// MARK: - IBActions
private extension FakeSplashViewController {}
