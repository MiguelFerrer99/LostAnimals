//
//  PersonalDetailsCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class PersonalDetailsCollectionViewCell: UICollectionViewCell, ViewModelCell {
    typealias T = PersonalDetailsCollectionViewCellViewModel
    // MARK: - IBOutlets
    @IBOutlet private weak var personalDetailsTextLabel: UILabel!
    @IBOutlet private weak var personalDetailsModeButton: UIButton!
    @IBOutlet weak var firstnameTextfield: CustomTextField!
    @IBOutlet weak var lastnameTextfield: CustomTextField!
    @IBOutlet weak var birthdateTexfield: CustomTextField!
    @IBOutlet weak var whereDoYouLiveTextfield: CustomTextField!
    @IBOutlet weak var animalShelterNameTextfield: CustomTextField!
    @IBOutlet weak var whereCanWeFindYouTextfield: CustomTextField!
    @IBOutlet weak var nextStepButton: CustomButton!
    
    // MARK: - Properties
    weak var signUpStepsDelegate: SignUpStepsDelegate?
    var viewModel: PersonalDetailsCollectionViewCellViewModel! {
        didSet { fillUI() }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
}

// MARK: - Functions
extension PersonalDetailsCollectionViewCell {
    func fillWhereDoYouLive(whereDoYouLive: String) {
        whereDoYouLiveTextfield.textField.text = whereDoYouLive
        whereDoYouLiveTextfield.didFinishSelectContentFromOtherVC()
        convertAddressToLocation(address: whereDoYouLive)
    }
}

// MARK: - Private functions
private extension PersonalDetailsCollectionViewCell {
    func fillUI() {
        configureTextFields()
        setLocalizables()
    }
    
    func setLocalizables() {
        personalDetailsTextLabel.text = .SignUp.PersonalDetails.Text()
        firstnameTextfield.placeholder = .Commons.Firstname()
        lastnameTextfield.placeholder = .Commons.Lastname()
        birthdateTexfield.placeholder = .Commons.Birthdate()
        whereDoYouLiveTextfield.placeholder = .Commons.WhereDoYouLive()
        animalShelterNameTextfield.placeholder = .Commons.AnimalShelterName()
        whereCanWeFindYouTextfield.placeholder = .Commons.WhereCanWeFindYou()
        personalDetailsModeButton.setTitle(.SignUp.PersonalDetails.AnimalShelterButton(), for: .normal)
        nextStepButton.setTitle(.Commons.NextButton(), for: .normal)
    }
    
    func updatePersonalDetailsMode() {
        nextStepButton.alpha = 0.5
        nextStepButton.isEnabled = false
        if viewModel.isAnimalShelter {
            personalDetailsModeButton.setTitle(.SignUp.PersonalDetails.PersonButton(), for: .normal)
            firstnameTextfield.isHidden = true
            lastnameTextfield.isHidden = true
            birthdateTexfield.isHidden = true
            whereDoYouLiveTextfield.isHidden = true
            animalShelterNameTextfield.isHidden = false
            whereCanWeFindYouTextfield.isHidden = false
            animalShelterNameTextfield.resetTextfield()
            whereCanWeFindYouTextfield.resetTextfield()
        } else {
            personalDetailsModeButton.setTitle(.SignUp.PersonalDetails.AnimalShelterButton(), for: .normal)
            animalShelterNameTextfield.isHidden = true
            whereCanWeFindYouTextfield.isHidden = true
            firstnameTextfield.isHidden = false
            lastnameTextfield.isHidden = false
            birthdateTexfield.isHidden = false
            whereDoYouLiveTextfield.isHidden = false
            firstnameTextfield.resetTextfield()
            lastnameTextfield.resetTextfield()
            birthdateTexfield.resetTextfield()
            whereDoYouLiveTextfield.resetTextfield()
        }
    }
}

// MARK: - IBActions
private extension PersonalDetailsCollectionViewCell {
    @IBAction func areYouAnAnimalShelterButton(_ sender: UIButton) {
        viewModel.isAnimalShelter.toggle()
        updatePersonalDetailsMode()
    }
    
    @IBAction func nextStepButtonPressed(_ sender: CustomButton) {
        signUpStepsDelegate?.sendSignUpStep1Data(isAnimalShelter: viewModel.isAnimalShelter,
                                                 firstname: viewModel.isAnimalShelter ? animalShelterNameTextfield.value : firstnameTextfield.value,
                                                 lastname: viewModel.isAnimalShelter ? "" : lastnameTextfield.value,
                                                 birthdate: viewModel.isAnimalShelter ? nil : birthdateTexfield.value,
                                                 location: viewModel.location ?? Location(address: .Commons.NotSpecifiedFemale(), coordinates: nil))
        signUpStepsDelegate?.moveToNextSignUpStep()
    }
}
