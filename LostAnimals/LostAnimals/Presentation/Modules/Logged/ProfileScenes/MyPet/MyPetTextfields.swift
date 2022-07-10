//
//  MyPetTextfields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

// MARK: - Functions
extension MyPetViewController {
    func configureTextfields() {
        animalNameTextfield.delegate = self
        animalNameTextfield.textField.textContentType        = .name
        animalNameTextfield.textField.keyboardType           = .alphabet
        animalNameTextfield.textField.autocapitalizationType = .sentences
        animalNameTextfield.textField.returnKeyType          = .next
        animalNameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                              TextFieldErrorOnlyLettersAndSpaces()])
        if viewModel.myPet != nil { animalNameTextfield.initEditableTextfield() }
        
        animalTypeTextfield.delegate = self
        animalTypeTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        if viewModel.myPet != nil { animalTypeTextfield.initEditableTextfield() }
        
        animalBreedTextfield.delegate = self
        animalBreedTextfield.textField.textContentType        = .name
        animalBreedTextfield.textField.keyboardType           = .alphabet
        animalBreedTextfield.textField.autocapitalizationType = .sentences
        animalBreedTextfield.textField.returnKeyType          = .next
        if viewModel.myPet != nil { animalBreedTextfield.initEditableTextfield() }
        
        if viewModel.myPet != nil { viewModel.editedTextFields = [animalNameTextfield, animalTypeTextfield] }
    }
    
    func configureTextView() {
        descriptionTextView.delegate = self
    }
    
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let hasAtLeastOnePhoto = viewModel.selectPhotoImageViews.contains(where: {
            guard let image = $0.image else { return false }
            return !image.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder"))
        })
        let currentAndNewInfoAreDifferent = viewModel.currentPetValues != viewModel.newPetValues || viewModel.imagesModified
        let canSaveChanges = !haveErrors && hasAtLeastOnePhoto && currentAndNewInfoAreDifferent && viewModel.numberOfTextFields <= viewModel.editedTextFields.count
        saveChangesButton.alpha = canSaveChanges ? 1 : 0.5
        saveChangesButton.isEnabled = canSaveChanges
    }
}

// MARK: - UITextViewDelegate
extension MyPetViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 300 { textView.text.removeLast() }
        else {
            descriptionCharactersCounterLabel.text = "\(textView.text.count)/300"
            viewModel.newPetValues[.description] = textView.text
            checkAllContentsAreOk()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.newPetValues[.description] = textView.text
        checkAllContentsAreOk()
    }
}

// MARK: - CustomTextFieldDelegate
extension MyPetViewController: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField {
        case animalNameTextfield:
            customTextField.textField.resignFirstResponder()
        default: customTextField.textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldWillSelectAnimal(_ customTextField: CustomTextField) {
        animalNameTextfield.textField.endEditing(true)
        descriptionTextView.endEditing(true)
        animalBreedTextfield.textField.endEditing(true)
        textFieldDidBeginEditing(customTextField)
        viewModel.didPressAnimalTypeButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.textFieldDidChange(customTextField)
        }
    }
    
    func textFieldDidBeginEditing(_ customTextField: CustomTextField) {
        if !customTextField.errorsToCheck.isEmpty && viewModel.editedTextFields.first(where: {$0 == customTextField}) == nil {
            viewModel.editedTextFields.append(customTextField)
        }
    }
    
    func textFieldDidChange(_ customTextField: CustomTextField) {
        switch customTextField {
        case animalNameTextfield:
            viewModel.newPetValues[.name] = customTextField.value
        case animalBreedTextfield:
            viewModel.newPetValues[.breed] = customTextField.value
        default: break
        }
        checkAllContentsAreOk()
    }
    
    func textFieldDidEndEditing(_ customTextField: CustomTextField) {
        switch customTextField {
        case animalNameTextfield:
            viewModel.newPetValues[.name] = customTextField.value
        case animalBreedTextfield:
            viewModel.newPetValues[.breed] = customTextField.value
        default: break
        }
        checkAllContentsAreOk()
    }
}
