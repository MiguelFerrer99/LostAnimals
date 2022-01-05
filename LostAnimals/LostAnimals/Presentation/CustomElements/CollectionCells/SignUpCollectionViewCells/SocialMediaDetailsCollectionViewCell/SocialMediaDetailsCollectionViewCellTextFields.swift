//
//  SocialMediaDetailsCollectionViewCellTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 23/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension SocialMediaDetailsCollectionViewCell: CustomTextFieldDelegate {
  // MARK: - Functions
  func configureTextFields() {
    phoneTextfield.delegate = self
    phoneTextfield.textField.keyboardType = .numberPad
    phoneTextfield.textField.textContentType = .telephoneNumber
    phoneTextfield.textField.returnKeyType = .next
    phoneTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                     TextFieldErrorPhoneNumber()])
    
    instagramTextfield.delegate = self
    instagramTextfield.textField.keyboardType = .alphabet
    instagramTextfield.textField.textContentType = .nickname
    instagramTextfield.textField.returnKeyType = .next
    
    twitterTextfield.delegate = self
    twitterTextfield.textField.keyboardType = .alphabet
    twitterTextfield.textField.textContentType = .nickname
    twitterTextfield.textField.returnKeyType = .done
  }
  
  @objc func fillPhonePrefix(_ notification: NSNotification) {
    if let countryDialCodeString = notification.userInfo?["countryDialCodeString"] as? String {
      topPrefixPlaceholder.isHidden = false
      middlePrefixPlaceholder.isHidden = true
      phonePrefixLabel.text = "+\(countryDialCodeString)"
      viewModel.phonePrefixSelected = true
      errorPhonePrefixLabel.isHidden = true
      checkAllContentsAreOk()
    }
  }
  
  func didPresseddPhonePrefix() {
    phoneTextfield.textField.endEditing(true)
    instagramTextfield.textField.endEditing(true)
    twitterTextfield.textField.endEditing(true)
    signUpStepsDelegate?.goToWhereDoYouLiveCountries(comesFrom: .socialMediaDetails)
  }
  
  func checkAllContentsAreOk() {
    let haveErrors = viewModel.textFieldsHaveErrors()
    let canMoveToNextStep = !haveErrors && viewModel.numberOfTextFields <= viewModel.editedTextFields.count && viewModel.phonePrefixSelected && viewModel.termsAndContitionsAccepted
    getStartedButton.alpha = canMoveToNextStep ? 1 : 0.5
    getStartedButton.isEnabled = canMoveToNextStep
  }
  
  // MARK: - CustomTextFieldDelegate
  func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
    switch customTextField.textField {
    case phoneTextfield.textField:
      instagramTextfield.textField.becomeFirstResponder()
    case instagramTextfield.textField:
      twitterTextfield.textField.becomeFirstResponder()
    case twitterTextfield.textField:
      customTextField.textField.resignFirstResponder()
    default: customTextField.textField.resignFirstResponder()
    }
    return true
  }
  
  func textFieldDidBeginEditing(_ customTextField: CustomTextField) {
    if viewModel.editedTextFields.first(where: {$0 == customTextField}) == nil {
      viewModel.editedTextFields.append(customTextField)
    }
  }
  
  func textFieldDidChange(_ customTextField: CustomTextField) {
    if customTextField == phoneTextfield {
      viewModel.phonePrefixSelected = !(phonePrefixLabel.text?.isEmpty ?? true)
      errorPhonePrefixLabel.isHidden = viewModel.phonePrefixSelected
    }
    checkAllContentsAreOk()
  }
  
  func textFieldDidEndEditing(_ customTextField: CustomTextField) {
    if customTextField == phoneTextfield {
      viewModel.phonePrefixSelected = !(phonePrefixLabel.text?.isEmpty ?? true)
      errorPhonePrefixLabel.isHidden = viewModel.phonePrefixSelected
    }
    checkAllContentsAreOk()
  }
}
