//
//  TermTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 29/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class TermTableViewCell: UITableViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var termTitle: UILabel!
    @IBOutlet private weak var termDescription: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Functions
extension TermTableViewCell {
    func display(summary: TermTableViewCellSummary) {
        termTitle.text = summary.title
        termDescription.text = summary.description
    }
}
