//
//  AccountDetailsCollectionViewCellTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 21/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

extension AccountDetailsCollectionViewCell: CustomTextFieldDelegate {
  // MARK: - Functions
  func configureTextFields() {
    mailTextfield.delegate = self
    mailTextfield.textField.textContentType = .username
    mailTextfield.textField.keyboardType = .emailAddress
    mailTextfield.textField.returnKeyType = .next
    mailTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                    TextFieldErrorEmailFormat()])
    
    passwordTextfield.delegate = self
    passwordTextfield.textField.textContentType = .oneTimeCode
    passwordTextfield.textField.returnKeyType = .next
    passwordTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorPasswordFormat()])
    
    repeatPasswordTextfield.delegate = self
    repeatPasswordTextfield.textField.textContentType = .oneTimeCode
    repeatPasswordTextfield.textField.returnKeyType = .done
    repeatPasswordTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                              TextFieldErrorPasswordFormat()])
  }
  
  func checkPasswordsAreEqual() -> Bool {
    if passwordTextfield.textField.text == repeatPasswordTextfield.textField.text {
      return true
    } else if viewModel.editedTextFields.contains(passwordTextfield) && viewModel.editedTextFields.contains(repeatPasswordTextfield) {
      passwordTextfield.showPasswordsAreNotEqualError()
      repeatPasswordTextfield.showPasswordsAreNotEqualError()
      return false
    }
    return true
  }
  
  // MARK: - CustomTextFieldDelegate
  func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
    switch customTextField.textField {
    case mailTextfield.textField:
      passwordTextfield.textField.becomeFirstResponder()
    case passwordTextfield.textField:
      repeatPasswordTextfield.textField.becomeFirstResponder()
    case repeatPasswordTextfield.textField:
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
    checkAllContentsAreOk()
  }
  
  func textFieldDidEndEditing(_ customTextField: CustomTextField) {
    checkAllContentsAreOk()
  }
}
