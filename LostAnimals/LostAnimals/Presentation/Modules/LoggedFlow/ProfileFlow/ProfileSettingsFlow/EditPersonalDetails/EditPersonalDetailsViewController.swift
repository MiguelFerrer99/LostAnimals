//
//  EditPersonalDetailsViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditPersonalDetailsViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var animalShelterNameTextfield: CustomTextField!
    @IBOutlet weak var firstnameTextfield: CustomTextField!
    @IBOutlet weak var lastnameTextfield: CustomTextField!
    @IBOutlet weak var birthdateTextfield: CustomTextField!
    @IBOutlet weak var whereDoYouLiveTextfield: CustomTextField!
    @IBOutlet weak var whereCanWeFindYouTextfield: CustomTextField!
    @IBOutlet weak var saveChangesButton: CustomButton!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Edit personal details"
    }
    var viewModel: EditPersonalDetailsViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeToNotifications()
        setupUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
    deinit {
        unsubscribeToNotifications()
    }
    
    // MARK: - Functions
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(fillWhereDoYouLive), name: .SendWhereDoYouLiveToEditPersonalDetails, object: nil)
    }
    
    private func unsubscribeToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureTextFields()
        fillUI()
    }
    
    private func fillUI() {
        firstnameTextfield.isHidden = viewModel.me.isAnimalShelter
        lastnameTextfield.isHidden = viewModel.me.isAnimalShelter
        birthdateTextfield.isHidden = viewModel.me.isAnimalShelter
        whereDoYouLiveTextfield.isHidden = viewModel.me.isAnimalShelter
        animalShelterNameTextfield.isHidden = !viewModel.me.isAnimalShelter
        whereCanWeFindYouTextfield.isHidden = !viewModel.me.isAnimalShelter
        
        if viewModel.me.isAnimalShelter {
            animalShelterNameTextfield.textField.text = viewModel.me.firstname
            whereCanWeFindYouTextfield.textField.text = viewModel.me.location.address
        } else {
            firstnameTextfield.textField.text = viewModel.me.firstname
            lastnameTextfield.textField.text = viewModel.me.lastname
            birthdateTextfield.textField.text = viewModel.me.birthdate.toString(withFormat: DateFormat.dayMonthYearOther)
            whereDoYouLiveTextfield.textField.text = viewModel.me.location.address
        }
    }
    
    private func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = saveChangesButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = saveChangesButton.isEnabled
        firstnameTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        lastnameTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        birthdateTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        whereDoYouLiveTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        animalShelterNameTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        whereCanWeFindYouTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
    }
    
    // MARK: - IBActions
    @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
        saveChangesButton.showLoading()
        updateUserInteraction()
        viewModel.didPressedSaveChangesButton()
    }
}
