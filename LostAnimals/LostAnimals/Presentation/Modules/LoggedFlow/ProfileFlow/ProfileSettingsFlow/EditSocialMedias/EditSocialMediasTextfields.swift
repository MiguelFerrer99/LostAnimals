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
        let canSaveChanges = !haveErrors && viewModel.numberOfTextFields <= viewModel.editedTextFields.count
        let socialMediasDetailsModified = (viewModel.currentSocialMediasDetails != viewModel.newSocialMediasDetails) || (viewModel.haveWhatsAppSelected != viewModel.willHaveWhatsAppSelected)
        saveChangesButton.alpha = (canSaveChanges && socialMediasDetailsModified) ? 1 : 0.5
        saveChangesButton.isEnabled = canSaveChanges && socialMediasDetailsModified
    }
}

// MARK: - CustomTextFieldDelegate
extension EditSocialMediasViewController: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField {
        case phoneNumberTextfield:
            instagramTextfield.textField.resignFirstResponder()
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
        switch customTextField {
        case phoneNumberTextfield:
            self.viewModel.newSocialMediasDetails[.phoneNumber] = phoneNumberTextfield.value
        case instagramTextfield:
            self.viewModel.newSocialMediasDetails[.instagram] = instagramTextfield.value
        case twitterTextfield:
            self.viewModel.newSocialMediasDetails[.twitter] = twitterTextfield.value
        default: break
        }
        checkAllContentsAreOk()
    }
    
    func textFieldDidEndEditing(_ customTextField: CustomTextField) {
        switch customTextField {
        case phoneNumberTextfield:
            self.viewModel.newSocialMediasDetails[.phoneNumber] = phoneNumberTextfield.value
        case instagramTextfield:
            self.viewModel.newSocialMediasDetails[.instagram] = instagramTextfield.value
        case twitterTextfield:
            self.viewModel.newSocialMediasDetails[.twitter] = twitterTextfield.value
        default: break
        }
        checkAllContentsAreOk()
    }
}
