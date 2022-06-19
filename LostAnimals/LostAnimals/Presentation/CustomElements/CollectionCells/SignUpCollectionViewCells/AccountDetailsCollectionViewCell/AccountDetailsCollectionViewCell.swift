//
//  AccountDetailsCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class AccountDetailsCollectionViewCell: UICollectionViewCell, ViewModelCell {
    typealias T = AccountDetailsCollectionViewCellViewModel
    // MARK: - IBOutlets
    @IBOutlet private weak var accountDetailsTextLabel: UILabel!
    @IBOutlet private weak var passwordRequirementLabel: UILabel!
    @IBOutlet private weak var backStepButton: CustomButton!
    @IBOutlet weak var mailTextfield: CustomTextField!
    @IBOutlet weak var passwordTextfield: CustomTextField!
    @IBOutlet weak var repeatPasswordTextfield: CustomTextField!
    @IBOutlet weak var nextStepButton: CustomButton!
    
    // MARK: - Properties
    weak var signUpStepsDelegate: SignUpStepsDelegate?
    var viewModel: AccountDetailsCollectionViewCellViewModel! {
        didSet { fillUI() }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Private functions
private extension AccountDetailsCollectionViewCell {
    func fillUI() {
        configureTextFields()
        setLocalizables()
    }
    
    func setLocalizables() {
        accountDetailsTextLabel.text = .SignUp.AccountDetails.Text()
        mailTextfield.placeholder = .Commons.Mail()
        passwordTextfield.placeholder = .Commons.Password()
        repeatPasswordTextfield.placeholder = .Commons.ConfirmPassword()
        passwordRequirementLabel.text = .SignUp.AccountDetails.PasswordRequirement()
        backStepButton.setTitle(.Commons.BackButton(), for: .normal)
        nextStepButton.setTitle(.Commons.NextButton(), for: .normal)
    }
}

// MARK: - IBActions
private extension AccountDetailsCollectionViewCell {
    @IBAction func backStepButtonPressed(_ sender: CustomButton) {
        signUpStepsDelegate?.moveToPreviousSignUpStep()
    }
    
    @IBAction func nextStepButtonPressed(_ sender: CustomButton) {
        signUpStepsDelegate?.sendSignUpStep2Data(mail: mailTextfield.value, password: passwordTextfield.value)
        signUpStepsDelegate?.moveToNextSignUpStep()
    }
}
