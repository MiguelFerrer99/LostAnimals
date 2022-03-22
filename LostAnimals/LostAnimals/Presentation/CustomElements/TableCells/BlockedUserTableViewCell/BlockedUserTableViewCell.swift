//
//  BlockedUserTableViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol UnblockUserDelegate: AnyObject {
    func unblockUser(userID: String)
}

class BlockedUserTableViewCell: UITableViewCell, ViewModelCell {
    typealias T = BlockedUserTableViewCellViewModel
    // MARK: - IBOutlets
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var unblockButton: CustomButton!
    
    // MARK: - Properties
    var viewModel: BlockedUserTableViewCellViewModel!
    weak var delegate: UnblockUserDelegate?
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Functions
extension BlockedUserTableViewCell {
    func display(summary: BlockedUserTableViewCellSummary) {
        userImageView.image = summary.user.userImage
        userNameLabel.text = "\(summary.user.firstname) \(summary.user.lastname)"
    }
}

// MARK: - IBActions
private extension BlockedUserTableViewCell {
    @IBAction func unblockUserButtonPressed(_ sender: CustomButton) {
        delegate?.unblockUser(userID: viewModel.userID)
    }
}
