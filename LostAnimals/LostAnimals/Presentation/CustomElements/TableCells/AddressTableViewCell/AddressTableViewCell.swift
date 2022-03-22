//
//  AddressTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var addressName: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgView = UIView()
        bgView.backgroundColor = .customWhite.withAlphaComponent(0.3)
        self.selectedBackgroundView = bgView
    }
}

// MARK: - Functions
extension AddressTableViewCell {
    func display(summary: AddressTableViewCellSummary) {
        let searchResultString = summary.searchResult.subtitle.isEmpty ? summary.searchResult.title : "\(summary.searchResult.title), \(summary.searchResult.subtitle)"
        addressName.text = searchResultString
    }
}
