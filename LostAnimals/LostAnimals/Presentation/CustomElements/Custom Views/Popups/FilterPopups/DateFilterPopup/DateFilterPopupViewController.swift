//
//  DateFilterPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class DateFilterPopupViewController: ViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var postsPreviousToButton: UIButton!
    @IBOutlet weak var postsAfterButton: UIButton!
    @IBOutlet weak var postsPreviousToImageView: UIImageView!
    @IBOutlet weak var postsAfterImageView: UIImageView!
    @IBOutlet weak var postsPreviousToTextfield: UITextField!
    @IBOutlet weak var postsAfterTextfield: UITextField!
    @IBOutlet weak var applyFilterButton: CustomButton!
    
    // MARK: - Properties
    var viewModel: DateFilterPopupViewModel!
    let postsPreviousToDatePicker = UIDatePicker()
    let postsAfterDatePicker = UIDatePicker()
    
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
    private func setupUI() {
        configureTextfields()
    }
    
    private func updateApplyFilterButton() {
        applyFilterButton.alpha = (viewModel.postsPreviousToSelected || viewModel.postsAfterSelected) ? 1 : 0.5
        applyFilterButton.isEnabled = viewModel.postsPreviousToSelected || viewModel.postsAfterSelected
    }
    
    // MARK: - IBActions
    @IBAction func postsPreviousToButtonPressed(_ sender: UIButton) {
        viewModel.postsPreviousToSelected.toggle()
        postsPreviousToImageView.image = UIImage(systemName: viewModel.postsPreviousToSelected ? "checkmark.circle.fill" : "circle")
        updateApplyFilterButton()
    }
    
    @IBAction func postsAfterButtonPressed(_ sender: UIButton) {
        viewModel.postsAfterSelected.toggle()
        postsAfterImageView.image = UIImage(systemName: viewModel.postsAfterSelected ? "checkmark.circle.fill" : "circle")
        updateApplyFilterButton()
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        viewModel.didPressDismissButton()
    }
    
    @IBAction func applyFilterButtonPressed(_ sender: CustomButton) {
        viewModel.didPressApplyFilterButton()
    }
}
