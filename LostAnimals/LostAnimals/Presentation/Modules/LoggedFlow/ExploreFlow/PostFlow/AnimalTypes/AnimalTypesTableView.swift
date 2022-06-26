//
//  AnimalTypesTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension AnimalTypesViewController {
    func configureTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnimalTypeTableViewCell.self)
    }
}

// MARK: - UITableViewDelegate
extension AnimalTypesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnimalType = Constants.animalTypes[indexPath.row]
        viewModel.selectedAnimalType = selectedAnimalType
        viewModel.didSelectedAnimalType()
    }
}

// MARK: - UITableViewDataSource
extension AnimalTypesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.animalTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let animalType = Constants.animalTypes[indexPath.row]
        let animalTypeName = Constants.animalTypesNames[indexPath.row]
        let summary = AnimalTypeTableViewCellSummary(animalTypeTitle: animalTypeName, animalTypeImage: UIImage(named: animalType.rawValue) ?? UIImage())
        let cell = tableView.dequeue(AnimalTypeTableViewCell.self)
        cell.display(summary: summary)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
