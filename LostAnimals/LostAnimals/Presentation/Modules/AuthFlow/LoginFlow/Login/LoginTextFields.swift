//
//  LoginTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 23/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

// MARK: - Functions
extension LoginViewController {
    func configureTextFields() {
        mailTextField.delegate = self
        mailTextField.textField.textContentType = .username
        mailTextField.textField.keyboardType    = .emailAddress
        mailTextField.textField.returnKeyType = .next
        mailTextField.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorEmailFormat()])
        
        passwordTextField.delegate = self
        passwordTextField.textField.textContentType = .password
        passwordTextField.textField.returnKeyType = .done
        passwordTextField.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                            TextFieldErrorPasswordFormat()])
    }
}

// MARK: - Private functions
private extension LoginViewController {
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let canMoveToNextStep = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        logInButton.alpha = canMoveToNextStep ? 1 : 0.5
        logInButton.isEnabled = canMoveToNextStep
    }
}

// MARK: - CustomTextFieldDelegate
extension LoginViewController: CustomTextFieldDelegate {
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
        if !customTextField.errorsToCheck.isEmpty && viewModel.editedTextFields.first(where: {$0 == customTextField}) == nil {
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
