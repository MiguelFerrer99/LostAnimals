//
//  LoginTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 23/11/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

// MARK: - Functions
extension ForgotPasswordViewController {
    func configureTextFields() {
        mailTexfield.delegate = self
        mailTexfield.textField.textContentType = .emailAddress
        mailTexfield.textField.keyboardType    = .emailAddress
        mailTexfield.textField.returnKeyType = .done
        mailTexfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                       TextFieldErrorEmailFormat()])
    }
}

// MARK: - Private functions
private extension ForgotPasswordViewController {
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let canMoveToNextStep = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        forgotPasswordButton.alpha = canMoveToNextStep ? 1 : 0.5
        forgotPasswordButton.isEnabled = canMoveToNextStep
    }
}

// MARK: - CustomTextFieldDelegate
extension ForgotPasswordViewController: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField.textField {
        case mailTexfield.textField:
            mailTexfield.textField.resignFirstResponder()
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
