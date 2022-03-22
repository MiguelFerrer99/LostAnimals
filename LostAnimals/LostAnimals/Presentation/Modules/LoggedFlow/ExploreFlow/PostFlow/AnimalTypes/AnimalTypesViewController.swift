//
//  AnimalTypesViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol AnimalTypesDelegate: AnyObject {
    func getAnimalType(animalType: AnimalType)
}

final class AnimalTypesViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var animalTypesTableView: UITableView!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Select an animal type"
    }
    weak var delegate: AnimalTypesDelegate?
    var viewModel: AnimalTypesViewModel!
    
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

// MARK: - Private functions
extension AnimalTypesViewController {
    func setupUI() {
        configureTableView(animalTypesTableView)
    }
}
