//
//  AnimalFilterPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol AnimalFilterPopupDelegate: AnyObject {
    func animalFilterApplied(animalTypeName: String)
}

final class AnimalFilterPopupViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var selectAnimalLabel: UILabel!
    @IBOutlet private weak var animalsFilterTableView: UITableView!
    @IBOutlet private weak var applyFilterButton: CustomButton!
    
    // MARK: - Properties
    weak var delegate: AnimalFilterPopupDelegate?
    var viewModel: AnimalFilterPopupViewModel!
    
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

// MARK: - Functions
extension AnimalFilterPopupViewController {
    func enableApplyFilterButton() {
        applyFilterButton.alpha = 1
        applyFilterButton.isEnabled = true
    }
}

// MARK: - Private functions
private extension AnimalFilterPopupViewController {
    func setupUI() {
        configureTableView(animalsFilterTableView)
        setLocalizables()
        fillUI()
    }
    
    func setLocalizables() {
        selectAnimalLabel.text = .Commons.SelectAnimalYouWant()
        applyFilterButton.setTitle(.Commons.ApplyFilter(), for: .normal)
    }
    
    func fillUI() {
        if viewModel.loadData {
            if let animalFilter = Filters.currentFilters[.animal] {
                viewModel.selectedAnimalType = animalFilter.animalFiltered
                switch animalFilter.animalFiltered {
                case .dog:    selectAnimalCell(index: 0)
                case .bird:   selectAnimalCell(index: 1)
                case .cat:    selectAnimalCell(index: 2)
                case .turtle: selectAnimalCell(index: 3)
                case .snake:  selectAnimalCell(index: 4)
                case .rabbit: selectAnimalCell(index: 5)
                case .other:  selectAnimalCell(index: 6)
                case .none: break
                }
            }
            enableApplyFilterButton()
        }
    }
    
    func selectAnimalCell(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        animalsFilterTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
}

// MARK: - IBActions
private extension AnimalFilterPopupViewController {
    @IBAction func applyFilterButtonPressed(_ sender: CustomButton) {
        viewModel.didPressApplyFilterButton()
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        viewModel.didPressDismissButton()
    }
}
