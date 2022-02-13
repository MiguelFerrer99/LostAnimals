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
        fillUI()
    }
    
    
    private func fillUI() {
        if viewModel.loadData {
            if let dateFilter = Filters.currentFilters[.date] {
                if let previousDate = dateFilter.dateFilterDatesBeforeOf {
                    postsPreviousToTextfield.text = previousDate.toString(withFormat: DateFormat.dayMonthYearOther)
                    viewModel.postsPreviousToSelectedDate = previousDate
                    viewModel.postsPreviousToSelected.toggle()
                    postsPreviousToImageView.image = UIImage(systemName: viewModel.postsPreviousToSelected ? "checkmark.circle.fill" : "circle")
                }
                if let afterDate = dateFilter.dateFilterDatesAfterOf {
                    postsAfterTextfield.text = afterDate.toString(withFormat: DateFormat.dayMonthYearOther)
                    viewModel.postsAfterSelectedDate = afterDate
                    viewModel.postsAfterSelected.toggle()
                    postsAfterImageView.image = UIImage(systemName: viewModel.postsAfterSelected ? "checkmark.circle.fill" : "circle")
                }
                updateApplyFilterButton()
            }
        } else {
            postsPreviousToTextfield.text = Date.today.toString(withFormat: DateFormat.dayMonthYearOther)
            postsAfterTextfield.text = Date.today.toString(withFormat: DateFormat.dayMonthYearOther)
        }
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
        if viewModel.postsPreviousToSelected {
            let date = postsPreviousToTextfield.text?.toDate(withFormat: DateFormat.dayMonthYearOther) ?? Date.today
            viewModel.postsPreviousToSelectedDate = date
        } else {
            viewModel.postsPreviousToSelectedDate = nil
        }
        if viewModel.postsAfterSelected {
            let date = postsAfterTextfield.text?.toDate(withFormat: DateFormat.dayMonthYearOther) ?? Date.today
            viewModel.postsAfterSelectedDate = date
        } else {
            viewModel.postsAfterSelectedDate = nil
        }
        viewModel.didPressApplyFilterButton()
    }
}
