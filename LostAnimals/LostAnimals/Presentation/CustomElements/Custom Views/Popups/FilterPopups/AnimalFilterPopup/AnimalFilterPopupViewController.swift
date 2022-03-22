//
//  AnimalFilterPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 2/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class AnimalFilterPopupViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var animalsFilterTableView: UITableView!
    @IBOutlet private weak var applyFilterButton: CustomButton!
    
    // MARK: - Properties
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
    
    func disableApplyFilterButton() {
        applyFilterButton.alpha = 0.5
        applyFilterButton.isEnabled = false
    }
}

// MARK: - Private functions
private extension AnimalFilterPopupViewController {
    func setupUI() {
        configureTableView(animalsFilterTableView)
        fillUI()
    }
    
    func fillUI() {
        if viewModel.loadData {
            if let animalFilter = Filters.currentFilters[.animal] {
                if animalFilter.animalFilterDog {
                    selectAnimalCell(index: 0)
                    viewModel.selectedAnimalTypes.append(.dog)
                }
                if animalFilter.animalFilterBird {
                    selectAnimalCell(index: 1)
                    viewModel.selectedAnimalTypes.append(.bird)
                }
                if animalFilter.animalFilterCat {
                    selectAnimalCell(index: 2)
                    viewModel.selectedAnimalTypes.append(.cat)
                }
                if animalFilter.animalFilterTurtle {
                    selectAnimalCell(index: 3)
                    viewModel.selectedAnimalTypes.append(.turtle)
                }
                if animalFilter.animalFilterSnake {
                    selectAnimalCell(index: 4)
                    viewModel.selectedAnimalTypes.append(.snake)
                }
                if animalFilter.animalFilterRabbit {
                    selectAnimalCell(index: 5)
                    viewModel.selectedAnimalTypes.append(.rabbit)
                }
                if animalFilter.animalFilterOther {
                    selectAnimalCell(index: 6)
                    viewModel.selectedAnimalTypes.append(.other)
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
