//
//  LoginTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 23/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

extension ForgotPasswordViewController: CustomTextFieldDelegate {
  
  // MARK: - Functions
  func configureTextFields() {
    mailTexfield.delegate = self
    mailTexfield.textField.textContentType = .emailAddress
    mailTexfield.textField.keyboardType    = .emailAddress
    mailTexfield.textField.returnKeyType = .go
    mailTexfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                    TextFieldErrorEmailFormat()])
  }
  
  // MARK: - CustomTextFieldDelegate
  func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
    switch customTextField.textField {
    case mailTexfield.textField:
      mailTexfield.textField.resignFirstResponder()
    default: customTextField.textField.resignFirstResponder()
    }
    return true
  }
  
  func textFieldDidChange(_ customTextField: CustomTextField) {
    if viewModel.editedTextFields.first(where: {$0 == customTextField}) == nil {
      viewModel.editedTextFields.append(customTextField)
    }
    _ = viewModel.textFieldsHaveErrors()
  }
}
