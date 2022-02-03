//
//  EditPostTextfields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension EditPostViewController: CustomTextFieldDelegate {
    // MARK: - Functions
    func configureTextfields() {
        animalTextfield.delegate = self
        animalTextfield.initEditableTextfield()
        animalTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        
        nameTextfield.delegate = self
        nameTextfield.initEditableTextfield()
        nameTextfield.textField.textContentType = .name
        nameTextfield.textField.keyboardType    = .alphabet
        nameTextfield.textField.returnKeyType   = .next
        nameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorOnlyLettersAndSpaces()])
        
        breedTextfield.delegate = self
        breedTextfield.textField.textContentType = .name
        breedTextfield.textField.keyboardType    = .alphabet
        breedTextfield.textField.returnKeyType   = .next
        
        lastTimeSeenTextfield.delegate = self
        lastTimeSeenTextfield.initEditableTextfield()
        lastTimeSeenTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        
        locationTextfield.delegate = self
        locationTextfield.initEditableTextfield()
        locationTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        
        switch viewModel.post.postType {
        case .lost:
            viewModel.editedTextFields = [nameTextfield, animalTextfield, breedTextfield, lastTimeSeenTextfield, locationTextfield]
        case .found:
            viewModel.editedTextFields = [animalTextfield, breedTextfield, lastTimeSeenTextfield, locationTextfield]
        case .adopt:
            viewModel.editedTextFields = [nameTextfield, animalTextfield, breedTextfield]
        }
    }
    
    @objc func fillWhereCanWeFindYou(_ notification: NSNotification) {
        if let searchResult = notification.userInfo?["searchResult"] as? MKLocalSearchCompletion {
            let searchResultString1 = searchResult.title
            let searchResultString2 = searchResult.subtitle.isEmpty ? "" : ", \(searchResult.subtitle)"
            let searchResultString = "\(searchResultString1)\(searchResultString2)"
            locationTextfield.textField.text = searchResultString
            locationTextfield.didFinishSelectContentFromOtherVC()
            convertAddressToLocation(address: searchResultString)
        }
    }
    
    @objc func fillAnimal(_ notification: NSNotification) {
        if let animalType = notification.userInfo?["animalType"] as? AnimalType {
            animalTextfield.textField.text = animalType.rawValue
            animalTextfield.didFinishSelectContentFromOtherVC()
        }
    }
    
    private func convertAddressToLocation(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                self.viewModel.newPostLocation = Location(address: address, coordinates: Coordinates(lat: lat, long: long))
            }
        }
    }
    
    func checkAllContentsAreOk() {
        let haveErrors = viewModel.textFieldsHaveErrors()
        let hasAtLeastOnePhoto = viewModel.selectPhotoImageViews.contains(where: {
            guard let image = $0.image else { return false }
            return !image.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder"))
        })
        let canMoveToNextStep = !haveErrors && hasAtLeastOnePhoto && viewModel.editedTextFields.count == viewModel.numberOfTextFields
        saveChangesButton.alpha = canMoveToNextStep ? 1 : 0.5
        saveChangesButton.isEnabled = canMoveToNextStep
    }
    
    // MARK: - CustomTextFieldDelegate
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
        switch customTextField.textField {
        case nameTextfield.textField:
            customTextField.textField.resignFirstResponder()
        case breedTextfield.textField:
            lastTimeSeenTextfield.textField.becomeFirstResponder()
        case lastTimeSeenTextfield.textField:
            customTextField.textField.resignFirstResponder()
        default: customTextField.textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldWillSelectAnimal(_ customTextField: CustomTextField) {
        nameTextfield.textField.endEditing(true)
        breedTextfield.textField.endEditing(true)
        lastTimeSeenTextfield.textField.endEditing(true)
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
