//
//  ProfileSelectableHeader.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 31/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class ProfileSelectableHeader: UICollectionReusableView, Reusable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var selectableButton: UIButton!
    
    // MARK: - Properties
    var isSelectable = false {
        didSet { setupUI() }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func setupUI() {
        arrowImageView.isHidden = !isSelectable
        selectableButton.isHidden = !isSelectable
    }
    
    // MARK: - IBActions
    @IBAction func headerButtonPressed(_ sender: UIButton) {
        // TODO: - Call delegate function
    }
}
