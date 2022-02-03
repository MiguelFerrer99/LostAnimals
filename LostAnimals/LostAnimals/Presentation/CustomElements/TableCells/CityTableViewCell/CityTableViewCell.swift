//
//  CityTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 12/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet weak var cityName: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgView = UIView()
        bgView.backgroundColor = .customWhite.withAlphaComponent(0.3)
        self.selectedBackgroundView = bgView
    }
    
    // MARK: - Functions
    func display(summary: CityTableViewCellSummary) {
        cityName.text = summary.cityName
    }
}
