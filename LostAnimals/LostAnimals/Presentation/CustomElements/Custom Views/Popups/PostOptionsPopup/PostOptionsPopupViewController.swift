//
//  PostOptionsPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol ActionAfterPostOptionsDelegate: AnyObject {
    func goTo(action: ActionAfterPostOptions, postImageToShare: UIImage?)
}

// MARK: - Enums
enum ActionAfterPostOptions: String {
    case goToEditPost
    case showGuestPopup
    case showSuccessPopup
    case showErrorPopup
    case showActivityVC
}

final class PostOptionsPopupViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var editPostButtonView: UIView!
    @IBOutlet private weak var reportPostButtonView: UIView!
    
    // MARK: - Properties
    weak var delegate: ActionAfterPostOptionsDelegate?
    var viewModel: PostOptionsPopupViewModel!
    
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
private extension PostOptionsPopupViewController {
    func setupUI() {
        editPostButtonView.isHidden = (viewModel.comesFrom == .explore) || (viewModel.post.author != User.shared)
        reportPostButtonView.isHidden = viewModel.post.author == User.shared
    }
}

// MARK: - IBActions
private extension PostOptionsPopupViewController {
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        viewModel.didPressDismissButton()
    }
    
    @IBAction func editPostButtonPressed(_ sender: UIButton) {
        viewModel.didPressEditPostButton()
    }
    
    @IBAction func reportPostButtonPressed(_ sender: UIButton) {
        viewModel.didPressReportPostButton()
    }
    
    @IBAction func sharePostButtonPressed(_ sender: UIButton) {
        viewModel.didPressSharePostButton()
    }
}
