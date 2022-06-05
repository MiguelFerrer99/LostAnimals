//
//  EditPersonalDetailsTextfields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import MapKit
import CoreLocation

// MARK: - Functions
extension EditPersonalDetailsViewController {
    func configureTextFields() {
        firstnameTextfield.delegate = self
        firstnameTextfield.textField.keyboardType = .alphabet
        firstnameTextfield.textField.textContentType = .givenName
        firstnameTextfield.textField.autocapitalizationType = .words
        firstnameTextfield.textField.returnKeyType = .next
        firstnameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                             TextFieldErrorOnlyLettersAndSpaces(),
                                             TextFieldErrorMaximumCharacters(20)])
        firstnameTextfield.initEditableTextfield()
        
        lastnameTextfield.delegate = self
        lastnameTextfield.textField.keyboardType = .alphabet
        lastnameTextfield.textField.textContentType = .familyName
        lastnameTextfield.textField.autocapitalizationType = .words
        lastnameTextfield.textField.returnKeyType = .next
        lastnameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                            TextFieldErrorOnlyLettersAndSpaces(),
                                            TextFieldErrorMaximumCharacters(20)])
        lastnameTextfield.initEditableTextfield()
        
        birthdateTextfield.delegate = self
        birthdateTextfield.textField.returnKeyType = .next
        birthdateTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        birthdateTextfield.initEditableTextfield()
        
        whereDoYouLiveTextfield.delegate = self
        whereDoYouLiveTextfield.textField.returnKeyType = .done
        whereDoYouLiveTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        whereDoYouLiveTextfield.initEditableTextfield()
        
        animalShelterNameTextfield.delegate = self
        animalShelterNameTextfield.textField.keyboardType = .alphabet
        animalShelterNameTextfield.textField.textContentType = .name
        animalShelterNameTextfield.textField.autocapitalizationType = .none
        animalShelterNameTextfield.textField.returnKeyType = .done
        animalShelterNameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                                     TextFieldErrorOnlyLettersAndSpaces(),
                                                     TextFieldErrorMaximumCharacters(20)])
        animalShelterNameTextfield.initEditableTextfield()
        
        whereCanWeFindYouTextfield.delegate = self
        whereCanWeFindYouTextfield.textField.returnKeyType = .done
        whereCanWeFindYouTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        whereCanWeFindYouTextfield.initEditableTextfield()
        
        viewModel.editedTextFields = viewModel.me.animalShelter ? [animalShelterNameTextfield, whereCanWeFindYouTextfield] : [firstnameTextfield, lastnameTextfield, birthdateTextfield, whereDoYouLiveTextfield]
    }
    
    @objc func fillWhereDoYouLive(_ notification: NSNotification) {
        if let whereDoYouLive = notification.userInfo?["whereDoYouLive"] as? String {
            whereDoYouLiveTextfield.textField.text = whereDoYouLive
            whereDoYouLiveTextfield.didFinishSelectContentFromOtherVC()
            convertAddressToLocation(address: whereDoYouLive)
        }
    }
    
    @objc func fillWhereCanWeFindYou(searchResult: MKLocalSearchCompletion) {
        let searchResultString1 = searchResult.title
        let searchResultString2 = searchResult.subtitle.isEmpty ? "" : ", \(searchResult.subtitle)"
        let searchResultString = "\(searchResultString1)\(searchResultString2)"
        whereCanWeFindYouTextfield.textField.text = searchResultString
        whereCanWeFindYouTextfield.didFinishSelectContentFromOtherVC()
        convertAddressToLocation(address: searchResultString)
    }
}

// MARK: - Private functions
private extension EditPersonalDetailsViewController {
    func convertAddressToLocation(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                self.viewModel.newLocation = Location(address: address, coordinates: Coordinates(longitude: long, latitude: lat))
                self.checkAllContentsAreOk()
            }
        }
    }
    
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let canSaveChanges = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        let personalDetailsModified = (viewModel.currentPersonalDetailsValues != viewModel.newPersonalDetailsValues) || (viewModel.currentLocation != viewModel.newLocation)
        saveChangesButton.alpha = (canSaveChanges && personalDetailsModified) ? 1 : 0.5
        saveChangesButton.isEnabled = canSaveChanges && personalDetailsModified
    }
}

// MARK: - CustomTextFieldDelegate
extension EditPersonalDetailsViewController: CustomTextFieldDelegate {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        if viewModel.me.animalShelter {
            switch customTextField {
            case animalShelterNameTextfield:
                animalShelterNameTextfield.textField.resignFirstResponder()
            case whereCanWeFindYouTextfield:
                customTextField.textField.resignFirstResponder()
            default: customTextField.textField.resignFirstResponder()
            }
        } else {
            switch customTextField {
            case firstnameTextfield:
                lastnameTextfield.textField.becomeFirstResponder()
            case lastnameTextfield:
                birthdateTextfield.textField.becomeFirstResponder()
            case birthdateTextfield:
                birthdateTextfield.textField.resignFirstResponder()
            case whereDoYouLiveTextfield:
                customTextField.textField.resignFirstResponder()
            default: customTextField.textField.resignFirstResponder()
            }
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
        case firstnameTextfield, animalShelterNameTextfield:
            viewModel.newPersonalDetailsValues[.firstname] = customTextField.value
        case lastnameTextfield:
            viewModel.newPersonalDetailsValues[.lastname] = customTextField.value
        case birthdateTextfield:
            viewModel.newPersonalDetailsValues[.birthdate] = customTextField.value
        default: break
        }
        checkAllContentsAreOk()
    }
    
    func textFieldDidEndEditing(_ customTextField: CustomTextField) {
        switch customTextField {
        case firstnameTextfield, animalShelterNameTextfield:
            viewModel.newPersonalDetailsValues[.firstname] = customTextField.value
        case lastnameTextfield:
            viewModel.newPersonalDetailsValues[.lastname] = customTextField.value
        case birthdateTextfield:
            viewModel.newPersonalDetailsValues[.birthdate] = customTextField.value
        default: break
        }
        checkAllContentsAreOk()
    }
    
    func textFieldWillSelectCity(_ customTextField: CustomTextField) {
        firstnameTextfield.textField.endEditing(true)
        lastnameTextfield.textField.endEditing(true)
        birthdateTextfield.textField.endEditing(true)
        textFieldDidBeginEditing(customTextField)
        viewModel.didPressedWhereDoYouLiveButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.textFieldDidChange(customTextField)
        }
    }
    
    func textFieldWillSelectAddress(_ customTextField: CustomTextField) {
        animalShelterNameTextfield.textField.endEditing(true)
        textFieldDidBeginEditing(customTextField)
        viewModel.didPressedWhereCanWeFindYouButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.textFieldDidChange(customTextField)
        }
    }
}
