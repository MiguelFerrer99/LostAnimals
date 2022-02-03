//
//  AnimalTypesTableView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension AnimalTypesViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnimalTypeTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.animalTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let animalType = Constants.animalTypes[indexPath.row]
        let summary = AnimalTypeTableViewCellSummary(animalTypeTitle: animalType.rawValue, animalTypeImage: UIImage(named: animalType.rawValue) ?? UIImage())
        let cell = tableView.dequeue(AnimalTypeTableViewCell.self)
        cell.display(summary: summary)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnimalType = Constants.animalTypes[indexPath.row]
        viewModel.selectedAnimalType = selectedAnimalType
        viewModel.didSelectedAnimalType()
    }
}
