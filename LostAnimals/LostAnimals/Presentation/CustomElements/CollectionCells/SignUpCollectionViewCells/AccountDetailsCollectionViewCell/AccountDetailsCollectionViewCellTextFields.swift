//
//  AccountDetailsCollectionViewCellTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 21/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

// MARK: - Functions
extension AccountDetailsCollectionViewCell {
    func configureTextFields() {
        mailTextfield.delegate = self
        mailTextfield.textField.textContentType = .emailAddress
        mailTextfield.textField.keyboardType = .emailAddress
        mailTextfield.textField.returnKeyType = .next
        mailTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorEmailFormat()])
        
        passwordTextfield.delegate = self
        passwordTextfield.textField.textContentType = .newPassword
        passwordTextfield.textField.returnKeyType = .next
        passwordTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                            TextFieldErrorPasswordFormat()])
        
        repeatPasswordTextfield.delegate = self
        repeatPasswordTextfield.textField.textContentType = .newPassword
        repeatPasswordTextfield.textField.returnKeyType = .done
        repeatPasswordTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                                  TextFieldErrorPasswordFormat()])
    }
}

// MARK: - Private functions
private extension AccountDetailsCollectionViewCell {
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
    
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let passwordsAreEqual = checkPasswordsAreEqual()
        let canMoveToNextStep = !haveErrors && passwordsAreEqual && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        nextStepButton.alpha = canMoveToNextStep ? 1 : 0.5
        nextStepButton.isEnabled = canMoveToNextStep
    }
}

// MARK: - CustomTextFieldDelegate
extension AccountDetailsCollectionViewCell: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField {
        case mailTextfield:
            passwordTextfield.textField.becomeFirstResponder()
        case passwordTextfield:
            repeatPasswordTextfield.textField.becomeFirstResponder()
        case repeatPasswordTextfield:
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
