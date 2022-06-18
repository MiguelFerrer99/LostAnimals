//
//  CurrentLocationTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class CurrentLocationTableViewCell: UITableViewCell, Reusable {
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgView = UIView()
        bgView.backgroundColor = .customWhite.withAlphaComponent(0.3)
        self.selectedBackgroundView = bgView
    }
}
