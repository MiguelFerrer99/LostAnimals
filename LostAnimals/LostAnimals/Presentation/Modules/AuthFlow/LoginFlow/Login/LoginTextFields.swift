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
    
    private func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let canMoveToNextStep = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        logInButton.alpha = canMoveToNextStep ? 1 : 0.5
        logInButton.isEnabled = canMoveToNextStep
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
        checkAllContentsAreOk()
    }
    
    func textFieldDidEndEditing(_ customTextField: CustomTextField) {
        checkAllContentsAreOk()
    }
}
