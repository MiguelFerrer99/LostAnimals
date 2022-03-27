//
//  EditSocialMediasTextfields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

// MARK: - Functions
extension EditSocialMediasViewController {
    func configureTextFields() {
        phoneNumberTextfield.delegate = self
        phoneNumberTextfield.textField.keyboardType = .numberPad
        phoneNumberTextfield.textField.textContentType = .telephoneNumber
        phoneNumberTextfield.textField.returnKeyType = .next
        phoneNumberTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                               TextFieldErrorPhoneNumber()])
        phoneNumberTextfield.initEditableTextfield()
        
        instagramTextfield.delegate = self
        instagramTextfield.textField.keyboardType = .alphabet
        instagramTextfield.textField.textContentType = .nickname
        instagramTextfield.textField.returnKeyType = .next
        instagramTextfield.initEditableTextfield()
        
        twitterTextfield.delegate = self
        twitterTextfield.textField.keyboardType = .alphabet
        twitterTextfield.textField.textContentType = .nickname
        twitterTextfield.textField.returnKeyType = .done
        twitterTextfield.initEditableTextfield()
        
        viewModel.editedTextFields = [phoneNumberTextfield]
    }
    
    func didPresseddPhonePrefix() {
        phoneNumberTextfield.textField.endEditing(true)
        instagramTextfield.textField.endEditing(true)
        twitterTextfield.textField.endEditing(true)
        viewModel.didPressPhonePrefixButton()
    }
    
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let canMoveToNextStep = !haveErrors && viewModel.numberOfTextFields <= viewModel.editedTextFields.count
        saveChangesButton.alpha = canMoveToNextStep ? 1 : 0.5
        saveChangesButton.isEnabled = canMoveToNextStep
    }
}

// MARK: - CustomTextFieldDelegate
extension EditSocialMediasViewController: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField.textField {
        case phoneNumberTextfield.textField:
            instagramTextfield.textField.resignFirstResponder()
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
