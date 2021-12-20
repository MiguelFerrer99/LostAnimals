//
//  PersonalDetailsCollectionViewCellTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MapKit

extension PersonalDetailsCollectionViewCell: CustomTextFieldDelegate {
  // MARK: - Functions
  func configureTextFields() {
    firstnameTextfield.delegate = self
    firstnameTextfield.textField.returnKeyType = .next
    firstnameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                         TextFieldErrorOnlyLettersAndSpaces()])
    
    lastnameTextfield.delegate = self
    lastnameTextfield.textField.returnKeyType = .next
    lastnameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorOnlyLettersAndSpaces()])
    
    birthdateTexfield.delegate = self
    birthdateTexfield.textField.returnKeyType = .next
    birthdateTexfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                        TextFieldErrorDate()])
    
    whereDoYouLiveTextfield.delegate = self
    whereDoYouLiveTextfield.textField.returnKeyType = .done
    whereDoYouLiveTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
    
    animalShelterNameTextfield.delegate = self
    animalShelterNameTextfield.textField.returnKeyType = .done
    animalShelterNameTextfield.addErrorsToCheck([TextFieldErrorEmptyValue(),
                                                 TextFieldErrorOnlyLettersAndSpaces()])
    
    whereCanWeFindYouTextfield.delegate = self
    whereCanWeFindYouTextfield.textField.returnKeyType = .done
    whereCanWeFindYouTextfield.addErrorsToCheck([TextFieldErrorEmptyValue()])
  }
  
  @objc func fillWhereDoYouLive(_ notification: NSNotification) {
    if let whereDoYouLiveString = notification.userInfo?["whereDoYouLiveString"] as? String {
      whereDoYouLiveTextfield.textField.text = whereDoYouLiveString
      whereDoYouLiveTextfield.didFinishSelectWhereDoYouLiveCountryAndCity()
    }
  }
  
  @objc func fillWhereCanWeFindYou(_ notification: NSNotification) {
    if let searchResult = notification.userInfo?["searchResult"] as? MKLocalSearchCompletion {
      let searchResultString = "\(searchResult.title), \(searchResult.subtitle)"
      whereCanWeFindYouTextfield.textField.text = searchResultString
      whereCanWeFindYouTextfield.didFinishSelectWhereCanWeFindYouAddress()
    }
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
    let haveErrors = viewModel.textFieldsHaveErrors()
    nextStepButton.alpha = (haveErrors || viewModel.editedTextFields.count < viewModel.numberOfTextFields) ? 0.5 : 1
    nextStepButton.isEnabled = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
  }
  
  func textFieldDidEndEditing(_ customTextField: CustomTextField) {
    let haveErrors = viewModel.textFieldsHaveErrors()
    nextStepButton.alpha = (haveErrors || viewModel.editedTextFields.count < viewModel.numberOfTextFields) ? 0.5 : 1
    nextStepButton.isEnabled = !haveErrors && viewModel.editedTextFields.count == viewModel.numberOfTextFields
  }
  
  func textFieldWillSelectCity(_ customTextField: CustomTextField) {
    textFieldDidBeginEditing(customTextField)
    signUpStepsDelegate?.goToWhereDoYouLiveCountries()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.textFieldDidChange(customTextField)
    }
  }
  
  func textFieldWillSelectAddress(_ customTextField: CustomTextField) {
    textFieldDidBeginEditing(customTextField)
    signUpStepsDelegate?.goToWhereCanWeFindYou()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.textFieldDidChange(customTextField)
    }
  }
}
