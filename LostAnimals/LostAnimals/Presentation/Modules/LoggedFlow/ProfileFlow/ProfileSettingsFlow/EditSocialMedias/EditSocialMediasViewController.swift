//
//  EditSocialMediasViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 6/2/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditSocialMediasViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var phonePrefixLabel: UILabel!
    @IBOutlet weak var phonePrefixButton: UIButton!
    @IBOutlet weak var phoneNumberTextfield: CustomTextField!
    @IBOutlet weak var haveWhatsappButton: UIButton!
    @IBOutlet weak var haveWhatsappButtonImageView: UIImageView!
    @IBOutlet weak var instagramTextfield: CustomTextField!
    @IBOutlet weak var twitterTextfield: CustomTextField!
    @IBOutlet weak var saveChangesButton: CustomButton!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return "Edit social medias"
    }
    var viewModel: EditSocialMediasViewModel!
    
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
    
    // MARK: - Functions
    private func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureTextFields()
        fillUI()
    }
    
    private func fillUI() {
        if let phonePrefix = viewModel.me.socialMedias[.phonePrefix] {
            phonePrefixLabel.text = "+\(phonePrefix)"
        }
        phoneNumberTextfield.textField.text = viewModel.me.socialMedias[.phoneNumber]
        haveWhatsappButtonImageView.image = UIImage(systemName: viewModel.haveWhatsAppSelected ? "checkmark.circle.fill" : "circle")
        if let instagram = viewModel.me.socialMedias[.instagram] {
            instagramTextfield.textField.text = instagram
        }
        if let twitter = viewModel.me.socialMedias[.twitter] {
            twitterTextfield.textField.text = twitter
        }
    }
    
    func fillPhonePrefix(dialCode: String) {
        phonePrefixLabel.text = "+\(dialCode)"
        checkAllContentsAreOk()
    }
    
    private func toggleHaveWhatsAppButton() {
        viewModel.haveWhatsAppSelected.toggle()
        haveWhatsappButtonImageView.image = UIImage(systemName: viewModel.haveWhatsAppSelected ? "checkmark.circle.fill" : "circle")
    }
    
    private func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = saveChangesButton.isEnabled
        navigationController?.interactivePopGestureRecognizer?.isEnabled = saveChangesButton.isEnabled
        phonePrefixButton.isUserInteractionEnabled = saveChangesButton.isEnabled
        phoneNumberTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        haveWhatsappButton.isUserInteractionEnabled = saveChangesButton.isEnabled
        instagramTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        twitterTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
    }
    
    // MARK: - IBActions
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
