//
//  BlockedUsersViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class BlockedUsersViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var blockedUsersTableView: UITableView!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Blocked users"
    }
    var viewModel: BlockedUsersViewModel!
    
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
    
    // MARK: - Functions
    func updateUserInteraction(to: Bool) {
        navigationController?.navigationBar.isUserInteractionEnabled = to
        navigationController?.interactivePopGestureRecognizer?.isEnabled = to
        blockedUsersTableView.isUserInteractionEnabled = to
    }
    
    private func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureTableView(blockedUsersTableView)
    }
}
