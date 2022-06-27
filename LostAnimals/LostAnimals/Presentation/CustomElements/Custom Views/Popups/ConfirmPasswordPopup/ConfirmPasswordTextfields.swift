//
//  ConfirmPasswordTextfields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 27/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension ConfirmPasswordViewController {
    func configureTextfields() {
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.textField.textContentType = .password
        confirmPasswordTextField.textField.returnKeyType = .done
        confirmPasswordTextField.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                                   TextFieldErrorPasswordFormat()])
    }
}

// MARK: - Private functions
private extension ConfirmPasswordViewController {
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let canMoveToNextStep = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        deleteAccountButton.alpha = canMoveToNextStep ? 1 : 0.5
        deleteAccountButton.isEnabled = canMoveToNextStep
    }
}

// MARK: - CustomTextFieldDelegate
extension ConfirmPasswordViewController: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField {
        case confirmPasswordTextField:
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
