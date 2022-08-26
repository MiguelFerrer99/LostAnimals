//
//  EditPersonalDetailsViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 5/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol EditPersonalDetailsDelegate: AnyObject {
    func updatePersonalDetails()
}

final class EditPersonalDetailsViewController: ViewController {
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
        return .ProfileSettings.EditPersonalDetials()
    }
    override var navBarLeftButtons: [UIBarButtonItem] {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        return [backButton]
    }
    var viewModel: EditPersonalDetailsViewModel!
    weak var delegate: EditPersonalDetailsDelegate?
    
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
}

// MARK: - Private functions
private extension EditPersonalDetailsViewController {
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(fillWhereDoYouLive), name: .SendWhereDoYouLiveToEditPersonalDetails, object: nil)
    }
    
    func setupUI() {
        fillUI()
        configureTextFields()
        setLocalizables()
    }
    
    func fillUI() {
        firstnameTextfield.isHidden = viewModel.me.animalShelter
        lastnameTextfield.isHidden = viewModel.me.animalShelter
        birthdateTextfield.isHidden = viewModel.me.animalShelter
        whereDoYouLiveTextfield.isHidden = viewModel.me.animalShelter
        animalShelterNameTextfield.isHidden = !viewModel.me.animalShelter
        whereCanWeFindYouTextfield.isHidden = !viewModel.me.animalShelter
        if viewModel.me.animalShelter {
            animalShelterNameTextfield.textField.text = viewModel.me.firstname
            whereCanWeFindYouTextfield.textField.text = viewModel.me.location.address
        } else {
            firstnameTextfield.textField.text = viewModel.me.firstname
            lastnameTextfield.textField.text = viewModel.me.lastname
            birthdateTextfield.textField.text = viewModel.me.birthdate
            whereDoYouLiveTextfield.textField.text = viewModel.me.location.address
        }
    }
    
    func setLocalizables() {
        firstnameTextfield.placeholder = .Commons.Firstname()
        lastnameTextfield.placeholder = .Commons.Lastname()
        birthdateTextfield.placeholder = .Commons.Birthdate()
        whereDoYouLiveTextfield.placeholder = .Commons.WhereDoYouLive()
        animalShelterNameTextfield.placeholder = .Commons.AnimalName()
        whereCanWeFindYouTextfield.placeholder = .Commons.WhereCanWeFindYou()
        saveChangesButton.setTitle(.Commons.SaveChanges(), for: .normal)
    }
    
    func updateUserInteraction() {
        tabBarController?.tabBar.isUserInteractionEnabled = saveChangesButton.isEnabled
        navigationController?.navigationBar.isUserInteractionEnabled = saveChangesButton.isEnabled
        firstnameTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        lastnameTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        birthdateTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        whereDoYouLiveTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        animalShelterNameTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        whereCanWeFindYouTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
    }
    
    @objc func goBack() {
        viewModel.goBack()
    }
}

// MARK: - IBActions
private extension EditPersonalDetailsViewController {
    @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
        saveChangesButton.showLoading { self.updateUserInteraction() }
        viewModel.didPressedSaveChangesButton() {
            self.saveChangesButton.hideLoading { self.updateUserInteraction() }
            self.delegate?.updatePersonalDetails()
        }
    }
}
