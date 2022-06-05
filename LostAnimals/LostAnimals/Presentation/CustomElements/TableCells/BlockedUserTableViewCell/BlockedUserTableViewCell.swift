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

class BlockedUserTableViewCell: UITableViewCell, Reusable {
    // MARK: - IBOutlets
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var unblockButton: CustomButton!
    
    // MARK: - Properties
    weak var delegate: UnblockUserDelegate?
    private var userID = ""
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Functions
extension BlockedUserTableViewCell {
    func display(summary: BlockedUserTableViewCellSummary) {
        userID = summary.user.id
        userNameLabel.text = "\(summary.user.firstname) \(summary.user.lastname)"
        summary.user.userURLImage?.getURLImage { image in
            if let image = image { self.userImageView.image = image }
        }
    }
}

// MARK: - IBActions
private extension BlockedUserTableViewCell {
    @IBAction func unblockUserButtonPressed(_ sender: CustomButton) {
        delegate?.unblockUser(userID: userID)
    }
}
