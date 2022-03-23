//
//  ConfirmationPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 22/3/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class ConfirmationPopupViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: ConfirmationPopupViewModel!
    
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

// MARK: - Private functions
private extension ConfirmationPopupViewController {
    func setupUI() {
        fillUI()
    }
    
    func fillUI() {
        titleLabel.text = viewModel.titleText
    }
}

// MARK: - IBActions
private extension ConfirmationPopupViewController {
    @IBAction func noButtonPressed(_ sender: CustomButton) {
        viewModel.didPressNoButton()
    }
    
    @IBAction func yesButtonPressed(_ sender: CustomButton) {
        viewModel.didPressYesButton()
    }
}
