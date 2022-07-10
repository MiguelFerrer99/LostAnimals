//
//  ChangePasswordTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - Functions
extension ChangePasswordViewController {
    func configureTextFields() {
        passwordTextfield.delegate = self
        passwordTextfield.textField.textContentType = .oneTimeCode
        passwordTextfield.textField.returnKeyType = .next
        passwordTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                            TextFieldErrorPasswordFormat()])
        
        confirmPasswordTextfield.delegate = self
        confirmPasswordTextfield.textField.textContentType = .oneTimeCode
        confirmPasswordTextfield.textField.returnKeyType = .done
        confirmPasswordTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                                   TextFieldErrorPasswordFormat()])
    }
}

// MARK: - Private functions
private extension ChangePasswordViewController {
    func checkPasswordsAreEqual() -> Bool {
        if passwordTextfield.textField.text == confirmPasswordTextfield.textField.text {
            return true
        } else if viewModel.editedTextFields.contains(passwordTextfield) && viewModel.editedTextFields.contains(confirmPasswordTextfield) {
            passwordTextfield.showPasswordsAreNotEqualError()
            confirmPasswordTextfield.showPasswordsAreNotEqualError()
            return false
        }
        return true
    }
    
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let passwordsAreEqual = checkPasswordsAreEqual()
        let canMoveToNextStep = !haveErrors && passwordsAreEqual && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        saveChangesButton.alpha = canMoveToNextStep ? 1 : 0.5
        saveChangesButton.isEnabled = canMoveToNextStep
    }
}

// MARK: - CustomTextFieldDelegate
extension ChangePasswordViewController: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField {
        case passwordTextfield:
            confirmPasswordTextfield.textField.becomeFirstResponder()
        case confirmPasswordTextfield:
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
