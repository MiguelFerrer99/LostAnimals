//
//  WhereDoYouLiveCountriesViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 10/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class WhereDoYouLiveCountriesViewController: ViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var countriesTableView: UITableView!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Select your country"
    }
    private var searchController = UISearchController(searchResultsController: nil)
    var viewModel: WhereDoYouLiveCountriesViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewReady()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Functions
    private func setupUI() {
        configureSearchController(searchController)
        viewModel.getCountriesFromCountriesJson {
            configureTableview(countriesTableView)
        }
    }
}
