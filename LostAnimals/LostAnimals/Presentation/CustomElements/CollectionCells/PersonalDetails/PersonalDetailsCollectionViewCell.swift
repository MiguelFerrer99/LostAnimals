//
//  PersonalDetailsCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class PersonalDetailsCollectionViewCell: UICollectionViewCell, Reusable {
  
  // MARK: - IBOutlets
  @IBOutlet weak var firstnameTextfield: CustomTextField!
  @IBOutlet weak var lastnameTextfield: CustomTextField!
  @IBOutlet weak var birthdateTexfield: CustomTextField!
  @IBOutlet weak var whereDoYouLiveTextfield: CustomTextField!
  @IBOutlet weak var nextStepButton: CustomButton!
  
  // MARK: - Properties
  var editedTextFields = [CustomTextField]()
  weak var signUpStepsDelegate: SignUpStepsDelegate?
  weak var presenter: Presenter?
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupBindings()
    setupUI()
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
  }
  
  private func setupUI() {
    configureTextFields()
  }
  
  func textFieldsHaveErrors() -> Bool {
    var haveErrors = false
    editedTextFields.forEach { editedTextField in
      if editedTextField.hasError && !haveErrors {
        haveErrors = true
      }
    }
    return haveErrors
  }
  
  // MARK: - IBActions
  @IBAction func areYouAnAnimalShelterButton(_ sender: UIButton) {
    // TODO: Show AnimalShelter UI
  }
  
  @IBAction func nextStepButtonPressed(_ sender: CustomButton) {
    signUpStepsDelegate?.moveToNextSignUpStep()
  }
}
