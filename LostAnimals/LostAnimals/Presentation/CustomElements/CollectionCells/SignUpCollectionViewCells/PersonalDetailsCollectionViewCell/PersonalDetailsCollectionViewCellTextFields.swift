//
//  PersonalDetailsCollectionViewCellTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension PersonalDetailsCollectionViewCell: CustomTextFieldDelegate {
    // MARK: - Functions
    func configureTextFields() {
        firstnameTextfield.delegate = self
        firstnameTextfield.textField.keyboardType = .alphabet
        firstnameTextfield.textField.textContentType = .givenName
        firstnameTextfield.textField.autocapitalizationType = .words
        firstnameTextfield.textField.returnKeyType = .next
        firstnameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                             TextFieldErrorOnlyLettersAndSpaces(),
                                             TextFieldErrorMaximumCharacters(20)])
        
        lastnameTextfield.delegate = self
        lastnameTextfield.textField.keyboardType = .alphabet
        lastnameTextfield.textField.textContentType = .familyName
        lastnameTextfield.textField.autocapitalizationType = .words
        lastnameTextfield.textField.returnKeyType = .next
        lastnameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                            TextFieldErrorOnlyLettersAndSpaces(),
                                            TextFieldErrorMaximumCharacters(20)])
        
        birthdateTexfield.delegate = self
        birthdateTexfield.textField.returnKeyType = .next
        birthdateTexfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        
        whereDoYouLiveTextfield.delegate = self
        whereDoYouLiveTextfield.textField.returnKeyType = .done
        whereDoYouLiveTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        
        animalShelterNameTextfield.delegate = self
        animalShelterNameTextfield.textField.keyboardType = .alphabet
        animalShelterNameTextfield.textField.textContentType = .name
        animalShelterNameTextfield.textField.autocapitalizationType = .none
        animalShelterNameTextfield.textField.returnKeyType = .done
        animalShelterNameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                                     TextFieldErrorOnlyLettersAndSpaces(),
                                                     TextFieldErrorMaximumCharacters(20)])
        
        whereCanWeFindYouTextfield.delegate = self
        whereCanWeFindYouTextfield.textField.returnKeyType = .done
        whereCanWeFindYouTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
    }
    
    @objc func fillWhereDoYouLive(_ notification: NSNotification) {
        if let whereDoYouLiveString = notification.userInfo?["whereDoYouLiveString"] as? String {
            whereDoYouLiveTextfield.textField.text = whereDoYouLiveString
            whereDoYouLiveTextfield.didFinishSelectContentFromOtherVC()
            convertAddressToLocation(address: whereDoYouLiveString)
        }
    }
    
    @objc func fillWhereCanWeFindYou(_ notification: NSNotification) {
        if let searchResult = notification.userInfo?["searchResult"] as? MKLocalSearchCompletion {
            let searchResultString1 = searchResult.title
            let searchResultString2 = searchResult.subtitle.isEmpty ? "" : ", \(searchResult.subtitle)"
            let searchResultString = "\(searchResultString1)\(searchResultString2)"
            whereCanWeFindYouTextfield.textField.text = searchResultString
            whereCanWeFindYouTextfield.didFinishSelectContentFromOtherVC()
            convertAddressToLocation(address: searchResultString)
        }
    }
    
    private func convertAddressToLocation(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                self.viewModel.location = Location(address: address, coordinates: Coordinates(lat: lat, long: long))
            }
        }
    }
    
    private func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let canMoveToNextStep = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        nextStepButton.alpha = canMoveToNextStep ? 1 : 0.5
        nextStepButton.isEnabled = canMoveToNextStep
    }
    
    // MARK: - CustomTextFieldDelegate
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        if viewModel.isAnimalShelter {
            switch customTextField.textField {
            case animalShelterNameTextfield.textField:
                animalShelterNameTextfield.textField.resignFirstResponder()
            case whereCanWeFindYouTextfield.textField:
                customTextField.textField.resignFirstResponder()
            default: customTextField.textField.resignFirstResponder()
            }
        } else {
            switch customTextField.textField {
            case firstnameTextfield.textField:
                lastnameTextfield.textField.becomeFirstResponder()
            case lastnameTextfield.textField:
                birthdateTexfield.textField.becomeFirstResponder()
            case birthdateTexfield.textField:
                birthdateTexfield.textField.resignFirstResponder()
            case whereDoYouLiveTextfield.textField:
                customTextField.textField.resignFirstResponder()
            default: customTextField.textField.resignFirstResponder()
            }
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
    
    func textFieldWillSelectCity(_ customTextField: CustomTextField) {
        firstnameTextfield.textField.endEditing(true)
        lastnameTextfield.textField.endEditing(true)
        birthdateTexfield.textField.endEditing(true)
        textFieldDidBeginEditing(customTextField)
        signUpStepsDelegate?.goToWhereDoYouLiveCountries(comesFrom: .personalDetails)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.textFieldDidChange(customTextField)
        }
    }
    
    func textFieldWillSelectAddress(_ customTextField: CustomTextField) {
        animalShelterNameTextfield.textField.endEditing(true)
        textFieldDidBeginEditing(customTextField)
        signUpStepsDelegate?.goToWhereCanWeFindYou()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.textFieldDidChange(customTextField)
        }
    }
}
