//
//  SocialMediaDetailsCollectionViewCell.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class SocialMediaDetailsCollectionViewCell: UICollectionViewCell, ViewModelCell {
    typealias T = SocialMediaDetailsCollectionViewCellViewModel
    // MARK: - IBOutlets
    @IBOutlet private weak var socialMediaDetailsTextLabel: UILabel!
    @IBOutlet private weak var topPrefixPlaceholder: UILabel!
    @IBOutlet private weak var middlePrefixPlaceholder: UILabel!
    @IBOutlet private weak var phonePrefixButton: UIButton!
    @IBOutlet private weak var haveWhatsAppRadioButton: UIButton!
    @IBOutlet private weak var haveWhatsAppRadioButtonImageView: UIImageView!
    @IBOutlet private weak var haveWhatsAppLabel: UILabel!
    @IBOutlet private weak var termsAndConditionsRadioButton: UIButton!
    @IBOutlet private weak var termsAndConditionsRadioButtonImageView: UIImageView!
    @IBOutlet private weak var acceptTermsAndConditionsLabel: UILabel!
    @IBOutlet private weak var termsAndConditionsButton: UIButton!
    @IBOutlet private weak var backStepButton: CustomButton!
    @IBOutlet weak var phonePrefixLabel: UILabel!
    @IBOutlet weak var errorPhonePrefixLabel: UILabel!
    @IBOutlet weak var phoneTextfield: CustomTextField!
    @IBOutlet weak var instagramTextfield: CustomTextField!
    @IBOutlet weak var twitterTextfield: CustomTextField!
    @IBOutlet weak var getStartedButton: CustomButton!
    
    // MARK: - Properties
    weak var signUpStepsDelegate: SignUpStepsDelegate?
    var viewModel: SocialMediaDetailsCollectionViewCellViewModel! {
        didSet { fillUI() }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Functions
extension SocialMediaDetailsCollectionViewCell {
    func fillPhonePrefix(dialCode: String) {
        topPrefixPlaceholder.isHidden = false
        middlePrefixPlaceholder.isHidden = true
        phonePrefixLabel.text = "+\(dialCode)"
        viewModel.phonePrefixSelected = true
        errorPhonePrefixLabel.isHidden = true
        checkAllContentsAreOk()
    }
    
    func updateUserInteraction() {
        signUpStepsDelegate?.updateSignUpUserInteraction(isUserInteractionEnabled: getStartedButton.isEnabled)
        phonePrefixButton.isUserInteractionEnabled = getStartedButton.isEnabled
        phoneTextfield.isUserInteractionEnabled = getStartedButton.isEnabled
        haveWhatsAppRadioButton.isUserInteractionEnabled = getStartedButton.isEnabled
        instagramTextfield.isUserInteractionEnabled = getStartedButton.isEnabled
        twitterTextfield.isUserInteractionEnabled = getStartedButton.isEnabled
        termsAndConditionsRadioButton.isUserInteractionEnabled = getStartedButton.isEnabled
        termsAndConditionsButton.isUserInteractionEnabled = getStartedButton.isEnabled
        backStepButton.isUserInteractionEnabled = getStartedButton.isEnabled
    }
}

// MARK: - Private functions
private extension SocialMediaDetailsCollectionViewCell {
    func fillUI() {
        configureTextFields()
        configureTermsAndConditionsButton()
        setLocalizables()
    }
    
    func setLocalizables() {
        socialMediaDetailsTextLabel.text = .SignUp.SocialMediaDetails.Text()
        errorPhonePrefixLabel.text = .TextFieldErrors.Empty()
        phoneTextfield.placeholder = .Commons.Phone()
        haveWhatsAppLabel.text = .Commons.HaveWhatsApp()
        instagramTextfield.placeholder = .Commons.OptionalInstagram()
        twitterTextfield.placeholder = .Commons.OptionalTwitter()
        acceptTermsAndConditionsLabel.text = .SignUp.SocialMediaDetails.AcceptTermsAndConditions()
        backStepButton.setTitle(.Commons.BackButton(), for: .normal)
        getStartedButton.setTitle(.SignUp.SocialMediaDetails.GetStartedButton(), for: .normal)
    }
    
    func configureTermsAndConditionsButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.thick.rawValue
        ]
        let attributedString = NSAttributedString(string: .SignUp.SocialMediaDetails.TermsAndConditionsButton(), attributes: attributes)
        termsAndConditionsButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    func toggleHaveWhatsAppButton() {
        viewModel.haveWhatsAppSelected.toggle()
        haveWhatsAppRadioButtonImageView.image = UIImage(systemName: viewModel.haveWhatsAppSelected ? "checkmark.circle.fill" : "circle")
    }
    
    func toggleTermsAndConditionsButton() {
        viewModel.termsAndContitionsAccepted.toggle()
        termsAndConditionsRadioButtonImageView.image = UIImage(systemName: viewModel.termsAndContitionsAccepted ? "checkmark.circle.fill" : "circle")
        checkAllContentsAreOk()
    }
}

// MARK: - IBActions
private extension SocialMediaDetailsCollectionViewCell {
    @IBAction func phonePrefixButtonPressed(_ sender: UIButton) {
        didPresseddPhonePrefix()
    }
    
    @IBAction func haveWhatsAppButtonPressed(_ sender: UIButton) {
        toggleHaveWhatsAppButton()
    }
    
    @IBAction func termsAndConditionsRadioButtonPressed(_ sender: UIButton) {
        toggleTermsAndConditionsButton()
    }
    
    @IBAction func termsAndConditionsButtonPressed() {
        signUpStepsDelegate?.goToTermsAndConditions()
    }
    
    @IBAction func backStepButtonPressed(_ sender: CustomButton) {
        signUpStepsDelegate?.moveToPreviousSignUpStep()
    }
    
    @IBAction func getStartedButtonPressed(_ sender: CustomButton) {
        guard let phonePrefix = phonePrefixLabel.text else { return }
        let phoneNumber = phoneTextfield.value.components(separatedBy: .whitespaces).joined()
        getStartedButton.showLoading { self.updateUserInteraction() }
        signUpStepsDelegate?.sendSignUpStep3Data(phonePrefix: phonePrefix,
                                                 phoneNumber: phoneNumber,
                                                 whatsapp: viewModel.haveWhatsAppSelected ? "\(phonePrefix)\(phoneNumber)" : nil,
                                                 instagram: instagramTextfield.value.isEmpty ? nil : instagramTextfield.value,
                                                 twitter: twitterTextfield.value.isEmpty ? nil : twitterTextfield.value)
        signUpStepsDelegate?.moveToNextSignUpStep()
    }
}
