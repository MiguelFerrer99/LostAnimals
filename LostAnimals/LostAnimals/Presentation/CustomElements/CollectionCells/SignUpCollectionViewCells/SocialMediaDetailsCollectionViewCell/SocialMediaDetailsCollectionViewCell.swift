//
//  SocialMediaDetailsCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

class SocialMediaDetailsCollectionViewCell: UICollectionViewCell, ViewModelCell {
    typealias T = SocialMediaDetailsCollectionViewCellViewModel
    
    // MARK: - IBOutlets
    @IBOutlet weak var topPrefixPlaceholder: UILabel!
    @IBOutlet weak var middlePrefixPlaceholder: UILabel!
    @IBOutlet weak var phonePrefixLabel: UILabel!
    @IBOutlet weak var errorPhonePrefixLabel: UILabel!
    @IBOutlet weak var phonePrefixButton: UIButton!
    @IBOutlet weak var phoneTextfield: CustomTextField!
    @IBOutlet weak var haveWhatsAppRadioButton: UIButton!
    @IBOutlet weak var haveWhatsAppRadioButtonImageView: UIImageView!
    @IBOutlet weak var instagramTextfield: CustomTextField!
    @IBOutlet weak var twitterTextfield: CustomTextField!
    @IBOutlet weak var termsAndConditionsRadioButton: UIButton!
    @IBOutlet weak var termsAndConditionsRadioButtonImageView: UIImageView!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var backStepButton: CustomButton!
    @IBOutlet weak var getStartedButton: CustomButton!
    
    // MARK: - Properties
    weak var signUpStepsDelegate: SignUpStepsDelegate?
    var viewModel: SocialMediaDetailsCollectionViewCellViewModel! {
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
        NotificationCenter.default.addObserver(self, selector: #selector(fillPhonePrefix), name: .SendCountryDialCodeToSignUp, object: nil)
    }
    
    private func unsubscribeToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func fillUI() {
        configureTextFields()
        configureTermsAndConditionsButton()
    }
    
    private func configureTermsAndConditionsButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.thick.rawValue
        ]
        let attributedString = NSAttributedString(string: "Terms and Conditions", attributes: attributes)
        termsAndConditionsButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func toggleHaveWhatsAppButton() {
        viewModel.haveWhatsAppSelected.toggle()
        haveWhatsAppRadioButtonImageView.image = UIImage(systemName: viewModel.haveWhatsAppSelected ? "checkmark.circle.fill" : "circle")
    }
    
    private func toggleTermsAndConditionsButton() {
        viewModel.termsAndContitionsAccepted.toggle()
        termsAndConditionsRadioButtonImageView.image = UIImage(systemName: viewModel.termsAndContitionsAccepted ? "checkmark.circle.fill" : "circle")
        checkAllContentsAreOk()
    }
    
    private func updateUserInteraction() {
        signUpStepsDelegate?.updateSignUpUserInteraction(isUserInteractionEnabled: false)
        phonePrefixButton.isUserInteractionEnabled = getStartedButton.isEnabled
        phoneTextfield.isUserInteractionEnabled = getStartedButton.isEnabled
        haveWhatsAppRadioButton.isUserInteractionEnabled = getStartedButton.isEnabled
        instagramTextfield.isUserInteractionEnabled = getStartedButton.isEnabled
        twitterTextfield.isUserInteractionEnabled = getStartedButton.isEnabled
        termsAndConditionsRadioButton.isUserInteractionEnabled = getStartedButton.isEnabled
        termsAndConditionsButton.isUserInteractionEnabled = getStartedButton.isEnabled
        backStepButton.isUserInteractionEnabled = getStartedButton.isEnabled
    }
    
    // MARK: - IBActions
    @IBAction func phonePrefixButtonPressed(_ sender: UIButton) {
        didPresseddPhonePrefix()
    }
    
    @IBAction func haveWhatsAppButtonPressed(_ sender: UIButton) {
        toggleHaveWhatsAppButton()
    }
    
    @IBAction func termsAndConditionsRadioButtonPressed(_ sender: UIButton) {
        toggleTermsAndConditionsButton()
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        signUpStepsDelegate?.goToTermsAndConditions()
    }
    
    @IBAction func backStepButtonPressed(_ sender: CustomButton) {
        signUpStepsDelegate?.moveToPreviousSignUpStep()
    }
    
    @IBAction func getStartedButtonPressed(_ sender: CustomButton) {
        getStartedButton.showLoading()
        updateUserInteraction()
        let fullPhone = "\(phonePrefixLabel.text ?? "")\(phoneTextfield.textField.text ?? "")"
        signUpStepsDelegate?.sendSignUpStep3Data(fullPhone: fullPhone,
                                                 whatsapp: viewModel.haveWhatsAppSelected ? fullPhone : nil,
                                                 instagram: instagramTextfield.textField.text,
                                                 twitter: twitterTextfield.textField.text)
        signUpStepsDelegate?.moveToNextSignUpStep()
    }
}
