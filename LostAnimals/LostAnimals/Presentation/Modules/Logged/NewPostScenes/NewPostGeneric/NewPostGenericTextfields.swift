//
//  NewPostGenericTextfields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

// MARK: - Functions
extension NewPostGenericViewController {
    func configureTextfields() {
        nameTextfield.delegate = self
        nameTextfield.textField.textContentType        = .name
        nameTextfield.textField.keyboardType           = .alphabet
        nameTextfield.textField.autocapitalizationType = .sentences
        nameTextfield.textField.returnKeyType          = .next
        nameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorOnlyLettersAndSpaces()])
        
        animalTextfield.delegate = self
        animalTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        
        breedTextfield.delegate = self
        breedTextfield.textField.textContentType        = .name
        breedTextfield.textField.keyboardType           = .alphabet
        breedTextfield.textField.autocapitalizationType = .sentences
        breedTextfield.textField.returnKeyType          = .next
        
        lastTimeSeenTextfield.delegate = self
        lastTimeSeenTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        
        locationTextfield.delegate = self
        locationTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        
        if viewModel.postToLoad != nil {
            nameTextfield.initEditableTextfield()
            animalTextfield.initEditableTextfield()
            breedTextfield.initEditableTextfield()
            lastTimeSeenTextfield.initEditableTextfield()
            locationTextfield.initEditableTextfield()
            viewModel.editedTextFields = [nameTextfield, animalTextfield, lastTimeSeenTextfield, locationTextfield]
        }
    }
    
    func configureTextView() {
        descriptionTextview.delegate = self
    }
    
    func fillWhereCanWeFindYou(searchResult: MKLocalSearchCompletion) {
        let searchResultString1 = searchResult.title
        let searchResultString2 = searchResult.subtitle.isEmpty ? "" : ", \(searchResult.subtitle)"
        let searchResultString = "\(searchResultString1)\(searchResultString2)"
        locationTextfield.textField.text = searchResultString
        locationTextfield.didFinishSelectContentFromOtherVC()
        convertAddressToLocation(address: searchResultString)
    }
    
    func fillWhereCanWeFindYou(addressString: String) {
        locationTextfield.textField.text = addressString
        locationTextfield.didFinishSelectContentFromOtherVC()
        convertAddressToLocation(address: addressString)
    }
    
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let hasAtLeastOnePhoto = viewModel.photosSelected.contains(true)
        let canMoveToNextStep = !haveErrors && hasAtLeastOnePhoto && viewModel.editedTextFields.count >= viewModel.numberOfTextFields
        publishPostButton.alpha = canMoveToNextStep ? 1 : 0.5
        publishPostButton.isEnabled = canMoveToNextStep
    }
}

// MARK: - Private functions
private extension NewPostGenericViewController {
    func convertAddressToLocation(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                self.viewModel.newPostLocation = Location(address: address, coordinates: Coordinates(longitude: long, latitude: lat))
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension NewPostGenericViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 300 { textView.text.removeLast() }
        else { descriptionCharactersCounterLabel.text = "\(textView.text.count)/300" }
    }
}

// MARK: - CustomTextFieldDelegate
extension NewPostGenericViewController: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField {
        case nameTextfield:
            customTextField.textField.resignFirstResponder()
        case breedTextfield:
            lastTimeSeenTextfield.textField.becomeFirstResponder()
        case lastTimeSeenTextfield:
            customTextField.textField.resignFirstResponder()
        default: customTextField.textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldWillSelectAnimal(_ customTextField: CustomTextField) {
        nameTextfield.textField.endEditing(true)
        breedTextfield.textField.endEditing(true)
        lastTimeSeenTextfield.textField.endEditing(true)
        descriptionTextview.endEditing(true)
        textFieldDidBeginEditing(customTextField)
        viewModel.didPressAnimalTypeButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.textFieldDidChange(customTextField)
        }
    }
    
    func textFieldWillSelectAddress(_ customTextField: CustomTextField) {
        nameTextfield.textField.endEditing(true)
        breedTextfield.textField.endEditing(true)
        lastTimeSeenTextfield.textField.endEditing(true)
        textFieldDidBeginEditing(customTextField)
        viewModel.didPressLocationButton()
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
        checkAllContentsAreOk()
    }
    
    func textFieldDidEndEditing(_ customTextField: CustomTextField) {
        checkAllContentsAreOk()
    }
}
