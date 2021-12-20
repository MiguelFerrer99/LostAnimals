//
//  LoginTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 23/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

extension LoginViewController: CustomTextFieldDelegate {
  // MARK: - Functions
  func configureTextFields() {
    mailTextField.delegate = self
    mailTextField.textField.textContentType = .emailAddress
    mailTextField.textField.keyboardType    = .emailAddress
    mailTextField.textField.returnKeyType = .next
    mailTextField.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                    TextFieldErrorEmailFormat()])
    
    passwordTextField.delegate = self
    passwordTextField.textField.textContentType = .password
    passwordTextField.textField.returnKeyType = .go
    passwordTextField.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorPasswordFormat()])
  }
  
  // MARK: - CustomTextFieldDelegate
  func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
    switch customTextField.textField {
    case mailTextField.textField:
      passwordTextField.textField.becomeFirstResponder()
    case passwordTextField.textField:
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
    let haveErrors = viewModel.textFieldsHaveErrors()
    logInButton.alpha = (haveErrors || viewModel.editedTextFields.count < viewModel.numberOfTextFields) ? 0.5 : 1
    logInButton.isEnabled = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
  }
  
  func textFieldDidEndEditing(_ customTextField: CustomTextField) {
    let haveErrors = viewModel.textFieldsHaveErrors()
    logInButton.alpha = (haveErrors || viewModel.editedTextFields.count < viewModel.numberOfTextFields) ? 0.5 : 1
    logInButton.isEnabled = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
  }
}
