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

// MARK: - Functions
extension EditPostViewController {
    func configureTextfields() {
        animalTextfield.delegate = self
        animalTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        animalTextfield.initEditableTextfield()
        
        nameTextfield.delegate = self
        nameTextfield.textField.textContentType = .name
        nameTextfield.textField.keyboardType    = .alphabet
        nameTextfield.textField.returnKeyType   = .next
        nameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorOnlyLettersAndSpaces()])
        nameTextfield.initEditableTextfield()
        
        breedTextfield.delegate = self
        breedTextfield.textField.textContentType = .name
        breedTextfield.textField.keyboardType    = .alphabet
        breedTextfield.textField.returnKeyType   = .next
        breedTextfield.initEditableTextfield()
        
        lastTimeSeenTextfield.delegate = self
        lastTimeSeenTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        lastTimeSeenTextfield.initEditableTextfield()
        
        locationTextfield.delegate = self
        locationTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
        locationTextfield.initEditableTextfield()
        
        switch viewModel.post.postType {
        case .lost:
            viewModel.editedTextFields = [nameTextfield, animalTextfield, breedTextfield, lastTimeSeenTextfield, locationTextfield]
        case .found:
            viewModel.editedTextFields = [animalTextfield, breedTextfield, lastTimeSeenTextfield, locationTextfield]
        case .adopt:
            viewModel.editedTextFields = [nameTextfield, animalTextfield, breedTextfield]
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
        let hasAtLeastOnePhoto = viewModel.selectPhotoImageViews.contains(where: {
            guard let image = $0.image else { return false }
            return !image.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder"))
        })
        let currentAndNewInfoAreDifferent = viewModel.currentEditPostInfo != viewModel.newEditPostInfo || viewModel.currentLocation != viewModel.newLocation || viewModel.imagesModified
        let canSaveChanges = !haveErrors && hasAtLeastOnePhoto && currentAndNewInfoAreDifferent && viewModel.numberOfTextFields <= viewModel.editedTextFields.count
        saveChangesButton.alpha = canSaveChanges ? 1 : 0.5
        saveChangesButton.isEnabled = canSaveChanges
    }
}


// MARK: - Private functions
private extension EditPostViewController {
    func convertAddressToLocation(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                self.viewModel.newLocation = Location(address: address, coordinates: Coordinates(longitude: long, latitude: lat))
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension EditPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 300 { textView.text.removeLast() }
        else {
            descriptionCharactersCounterLabel.text = "\(textView.text.count)/300"
            viewModel.newEditPostInfo[.description] = textView.text
            checkAllContentsAreOk()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.newEditPostInfo[.description] = textView.text
        checkAllContentsAreOk()
    }
}

// MARK: - CustomTextFieldDelegate
extension EditPostViewController: CustomTextFieldDelegate {
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
        if !customTextField.errorsToCheck.isEmpty && viewModel.editedTextFields.first(where: {$0 == customTextField}) == nil {
            viewModel.editedTextFields.append(customTextField)
        }
    }
    
    func textFieldDidChange(_ customTextField: CustomTextField) {
        switch customTextField {
        case nameTextfield:
            viewModel.newEditPostInfo[.animalName] = customTextField.value
        case breedTextfield:
            viewModel.newEditPostInfo[.animalBreed] = customTextField.value
        case lastTimeSeenTextfield:
            viewModel.newEditPostInfo[.lastTimeSeen] = customTextField.value
        default: break
        }
        checkAllContentsAreOk()
    }
    
    func textFieldDidEndEditing(_ customTextField: CustomTextField) {
        switch customTextField {
        case nameTextfield:
            viewModel.newEditPostInfo[.animalName] = customTextField.value
        case breedTextfield:
            viewModel.newEditPostInfo[.animalBreed] = customTextField.value
        case lastTimeSeenTextfield:
            viewModel.newEditPostInfo[.lastTimeSeen] = customTextField.value
        default: break
        }
        checkAllContentsAreOk()
    }
}
