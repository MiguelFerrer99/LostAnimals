//
//  EditSocialMediasViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol EditSocialMediasDelegate: AnyObject {
    func updateSocialMedias()
}

final class EditSocialMediasViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet private weak var phonePrefixLabel: UILabel!
    @IBOutlet private weak var phonePrefixButton: UIButton!
    @IBOutlet private weak var haveWhatsappButton: UIButton!
    @IBOutlet private weak var haveWhatsappButtonImageView: UIImageView!
    @IBOutlet weak var phoneNumberTextfield: CustomTextField!
    @IBOutlet weak var instagramTextfield: CustomTextField!
    @IBOutlet weak var twitterTextfield: CustomTextField!
    @IBOutlet weak var saveChangesButton: CustomButton!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Edit social medias"
    }
    var viewModel: EditSocialMediasViewModel!
    weak var delegate: EditSocialMediasDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

// MARK: - Functions
extension EditSocialMediasViewController {
    func fillPhonePrefix(dialCode: String) {
        phonePrefixLabel.text = "+\(dialCode)"
        checkAllContentsAreOk()
    }
}

// MARK: - Private functions
private extension EditSocialMediasViewController {
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        fillUI()
        configureTextFields()
    }
    
    func fillUI() {
        if let phonePrefix = viewModel.me.socialMedias[.phonePrefix] { phonePrefixLabel.text = phonePrefix }
        phoneNumberTextfield.textField.text = viewModel.me.socialMedias[.phoneNumber]
        haveWhatsappButtonImageView.image = UIImage(systemName: viewModel.haveWhatsAppSelected ? "checkmark.circle.fill" : "circle")
        if let instagram = viewModel.me.socialMedias[.instagram] { instagramTextfield.textField.text = instagram }
        if let twitter = viewModel.me.socialMedias[.twitter] { twitterTextfield.textField.text = twitter }
    }
    
    func toggleHaveWhatsAppButton() {
        viewModel.haveWhatsAppSelected.toggle()
        haveWhatsappButtonImageView.image = UIImage(systemName: viewModel.haveWhatsAppSelected ? "checkmark.circle.fill" : "circle")
    }
    
    func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = saveChangesButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = saveChangesButton.isEnabled
        phonePrefixButton.isUserInteractionEnabled = saveChangesButton.isEnabled
        phoneNumberTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        haveWhatsappButton.isUserInteractionEnabled = saveChangesButton.isEnabled
        instagramTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        twitterTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
    }
}

// MARK: - IBActions
private extension EditSocialMediasViewController {
    @IBAction func phonePrefixButtonPressed(_ sender: UIButton) {
        didPresseddPhonePrefix()
    }
    
    @IBAction func haveWhatsappButtonPressed(_ sender: UIButton) {
        toggleHaveWhatsAppButton()
    }
    
    @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
        viewModel.didPressSaveChangesButton()
    }
}
