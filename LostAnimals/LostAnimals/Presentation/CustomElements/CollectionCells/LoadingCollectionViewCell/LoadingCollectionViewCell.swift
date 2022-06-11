//
//  LoadingCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/4/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class LoadingCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - Properties
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    
    // MARK: - Functions
    func display(_ summary: LoadingCollectionViewCellSummary) {
        indicatorView.style = summary.activityIndicatorStyle
    }
}
