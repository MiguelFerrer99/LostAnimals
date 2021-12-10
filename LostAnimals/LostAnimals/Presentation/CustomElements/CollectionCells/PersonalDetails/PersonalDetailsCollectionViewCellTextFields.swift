//
//  PersonalDetailsCollectionViewCellTextFields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 9/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation
import UIKit

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
  }
  
  // MARK: - CustomTextFieldDelegate
  func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool {
    switch customTextField.textField {
    case firstnameTextfield.textField:
      lastnameTextfield.textField.becomeFirstResponder()
    case lastnameTextfield.textField:
      birthdateTexfield.textField.becomeFirstResponder()
    case birthdateTexfield.textField:
      textFieldWillSelectCity(whereDoYouLiveTextfield)
    case whereDoYouLiveTextfield.textField:
      customTextField.textField.resignFirstResponder()
    default: customTextField.textField.resignFirstResponder()
    }
    return true
  }
  
  func textFieldDidBeginEditing(_ customTextField: CustomTextField) {
    if editedTextFields.first(where: {$0 == customTextField}) == nil {
      editedTextFields.append(customTextField)
    }
  }
  
  func textFieldDidChange(_ customTextField: CustomTextField) {
    let haveErrors = textFieldsHaveErrors()
    nextStepButton.alpha = (haveErrors || editedTextFields.count < 4) ? 0.5 : 1
    nextStepButton.isEnabled = !haveErrors && editedTextFields.count == 4
  }
  
  func textFieldDidEndEditing(_ customTextField: CustomTextField) {
    let haveErrors = textFieldsHaveErrors()
    nextStepButton.alpha = (haveErrors || editedTextFields.count < 4) ? 0.5 : 1
    nextStepButton.isEnabled = !haveErrors && editedTextFields.count == 4
  }
  
  func textFieldWillSelectCity(_ customTextField: CustomTextField) {
    // TODO: Push WhereDoYouLiveVC
//    let viewController = UIViewController.instantiate(viewController: X.self)
//    let viewModel = XViewModel(router: router)
//    viewController.viewModel = viewModel
//    self.presenter?.presentWithNavBar(viewController: viewController, completion: nil)
  }
}
