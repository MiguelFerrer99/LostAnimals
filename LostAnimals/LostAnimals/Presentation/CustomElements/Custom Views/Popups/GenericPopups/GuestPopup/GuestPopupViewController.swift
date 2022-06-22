//
//  GuestPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class GuestPopupViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var guestPopupTitle: UILabel!
    @IBOutlet private weak var guestPopupButton: CustomButton!
    
    // MARK: - Properties
    var viewModel: GuestPopupViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewReady()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.6
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0
        }
    }
}

private extension GuestPopupViewController {
    func setupUI() {
        guestPopupTitle.text = .Commons.GuestPopupTitle()
        guestPopupButton.setTitle(.Commons.GoToStartup(), for: .normal)
    }
}

// MARK: - IBActions
private extension GuestPopupViewController {
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        viewModel.didPressDismissButton()
    }
    
    @IBAction func startupButtonPressed(_ sender: UIButton) {
        viewModel.didPressGoToStartupButton()
    }
}
