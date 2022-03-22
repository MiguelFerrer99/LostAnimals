//
//  SelectPhotoPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol ActionAfterSelectPhotoDelegate: AnyObject {
    func goTo(action: ActionAfterSelectPhoto)
}

// MARK: - Enums
enum ActionAfterSelectPhoto: String {
    case removePhoto
    case choosePhoto
    case takePhoto
}

final class SelectPhotoPopupViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var removePhotoOptionView: UIView!
    
    // MARK: - Properties
    weak var delegate: ActionAfterSelectPhotoDelegate?
    var viewModel: SelectPhotoPopupViewModel!
    
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

// MARK: - Functions
private extension SelectPhotoPopupViewController {
    func setupUI() {
        removePhotoOptionView.isHidden = !viewModel.showRemoveOption
    }
}

// MARK: - IBActions
private extension SelectPhotoPopupViewController {
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        viewModel.didPressDismissButton()
    }
    
    @IBAction func removePhotoButtonPressed(_ sender: UIButton) {
        viewModel.didPressRemovePhotoButton()
    }
    
    @IBAction func chooseFromLibraryButtonPressed(_ sender: UIButton) {
        viewModel.didPressChooseFromLibraryButton()
    }
    
    @IBAction func takeAPhotoButtonPressed(_ sender: UIButton) {
        viewModel.didPressTakeAPhotoButton()
    }
}
