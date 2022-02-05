//
//  BlockedUserTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

class BlockedUserTableViewCell: UITableViewCell, ViewModelCell {
    typealias T = BlockedUserTableViewCellViewModel
    
    // MARK: - IBOutlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: BlockedUserTableViewCellViewModel!
    weak var delegate: UnblockUserDelegate?
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func display(summary: BlockedUserTableViewCellSummary) {
        userImageView.image = summary.user.profileImage
        userNameLabel.text = "\(summary.user.firstname) \(summary.user.lastname)"
    }
    
    @IBAction func unblockUserButtonPressed(_ sender: CustomButton) {
        delegate?.unblockUser(userID: viewModel.userID)
    }
}
