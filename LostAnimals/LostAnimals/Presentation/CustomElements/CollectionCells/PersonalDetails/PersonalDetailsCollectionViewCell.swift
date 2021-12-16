//
//  PersonalDetailsCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class PersonalDetailsCollectionViewCell: UICollectionViewCell, ViewModelCell {
  typealias T = PersonalDetailsCollectionViewCellViewModel
  
  // MARK: - IBOutlets
  @IBOutlet weak var firstnameTextfield: CustomTextField!
  @IBOutlet weak var lastnameTextfield: CustomTextField!
  @IBOutlet weak var birthdateTexfield: CustomTextField!
  @IBOutlet weak var whereDoYouLiveTextfield: CustomTextField!
  @IBOutlet weak var nextStepButton: CustomButton!
  
  // MARK: - Properties
  weak var signUpStepsDelegate: SignUpStepsDelegate?
  var viewModel: PersonalDetailsCollectionViewCellViewModel! {
    didSet { fillUI() }
  }
  
  // MARK: - Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setupBindings()
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
  }
  
  private func fillUI() {
    configureTextFields()
  }
  
  // MARK: - IBActions
  @IBAction func areYouAnAnimalShelterButton(_ sender: UIButton) {
    // TODO: Show AnimalShelter UI
  }
  
  @IBAction func nextStepButtonPressed(_ sender: CustomButton) {
    signUpStepsDelegate?.moveToNextSignUpStep()
  }
}
