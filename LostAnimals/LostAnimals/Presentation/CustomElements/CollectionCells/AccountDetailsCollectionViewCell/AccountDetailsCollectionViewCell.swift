//
//  AccountDetailsCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class AccountDetailsCollectionViewCell: UICollectionViewCell, ViewModelCell {
  typealias T = AccountDetailsCollectionViewCellViewModel
  
  // MARK: - IBOutlets
  @IBOutlet weak var mailTextfield: CustomTextField!
  @IBOutlet weak var passwordTextfield: CustomTextField!
  @IBOutlet weak var repeatPasswordTextfield: CustomTextField!
  @IBOutlet weak var backStepButton: CustomButton!
  @IBOutlet weak var nextStepButton: CustomButton!
  
  // MARK: - Properties
  weak var signUpStepsDelegate: SignUpStepsDelegate?
  var viewModel: AccountDetailsCollectionViewCellViewModel! {
    didSet { fillUI() }
  }
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupBindings()
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
  }
  
  private func fillUI() {
    configureTextFields()
  }
  
  func checkAllContentsAreOk() {
    let haveErrors = viewModel.textFieldsHaveErrors()
    let passwordsAreEqual = checkPasswordsAreEqual()
    let canMoveToNextStep = !haveErrors && passwordsAreEqual && viewModel.editedTextFields.count == viewModel.numberOfTextFields
    nextStepButton.alpha = canMoveToNextStep ? 1 : 0.5
    nextStepButton.isEnabled = canMoveToNextStep
  }
  
  // MARK: - IBActions
  @IBAction func backStepButtonPressed(_ sender: CustomButton) {
    signUpStepsDelegate?.moveToPreviousSignUpStep()
  }
  
  @IBAction func nextStepButtonPressed(_ sender: CustomButton) {
    signUpStepsDelegate?.sendSignUpStep2Data(mail: mailTextfield.textField.text ?? "",
                                             password: passwordTextfield.textField.text ?? "")
    signUpStepsDelegate?.moveToNextSignUpStep()
  }
}
