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
    @IBOutlet weak var animalShelterNameTextfield: CustomTextField!
    @IBOutlet weak var whereCanWeFindYouTextfield: CustomTextField!
    @IBOutlet weak var personalDetailsModeButton: UIButton!
    @IBOutlet weak var nextStepButton: CustomButton!
    
    // MARK: - Properties
    weak var signUpStepsDelegate: SignUpStepsDelegate?
    var viewModel: PersonalDetailsCollectionViewCellViewModel! {
        didSet { fillUI() }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        subscribeToNotifications()
    }
    
    deinit {
        unsubscribeToNotifications()
    }
    
    // MARK: - Functions
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(fillWhereDoYouLive), name: .SendWhereDoYouLiveCountryAndCities, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fillWhereCanWeFindYou), name: .SendWhereCanWeFindYouAddressToSignUp, object: nil)
    }
    
    private func unsubscribeToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func fillUI() {
        configureTextFields()
    }
    
    private func updatePersonalDetailsMode() {
        nextStepButton.alpha = 0.5
        nextStepButton.isEnabled = false
        if viewModel.isAnimalShelter {
            personalDetailsModeButton.setTitle("Are you just a person?", for: .normal)
            firstnameTextfield.isHidden = true
            lastnameTextfield.isHidden = true
            birthdateTexfield.isHidden = true
            whereDoYouLiveTextfield.isHidden = true
            animalShelterNameTextfield.isHidden = false
            whereCanWeFindYouTextfield.isHidden = false
            animalShelterNameTextfield.resetTextfield()
            whereCanWeFindYouTextfield.resetTextfield()
        } else {
            personalDetailsModeButton.setTitle("Are you an animal shelter?", for: .normal)
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
    
    // MARK: - IBActions
    @IBAction func areYouAnAnimalShelterButton(_ sender: UIButton) {
        viewModel.isAnimalShelter.toggle()
        updatePersonalDetailsMode()
    }
    
    @IBAction func nextStepButtonPressed(_ sender: CustomButton) {
        signUpStepsDelegate?.sendSignUpStep1Data(isAnimalShelter: viewModel.isAnimalShelter,
                                                 firstname: firstnameTextfield.textField.text,
                                                 lastname: lastnameTextfield.textField.text,
                                                 animalShelterName: animalShelterNameTextfield.textField.text,
                                                 birthdate: birthdateTexfield.textField.text?.toDate(withFormat: DateFormat.dayMonthYearOther),
                                                 location: viewModel.location ?? Location(address: "", coordinates: nil))
        signUpStepsDelegate?.moveToNextSignUpStep()
    }
}
