//
//  SignUpViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit
import MapKit

// MARK: - Protocols
protocol SignUpStepsDelegate: AnyObject {
    func moveToNextSignUpStep()
    func moveToPreviousSignUpStep()
    func goToWhereDoYouLiveCountries(comesFrom: WhereDoYouLiveComesFrom)
    func goToWhereCanWeFindYou()
    func goToTermsAndConditions()
    func updateSignUpUserInteraction(isUserInteractionEnabled: Bool)
    func sendSignUpStep1Data(isAnimalShelter: Bool, firstname: String, lastname: String, birthdate: String?, location: Location)
    func sendSignUpStep2Data(mail: String, password: String)
    func sendSignUpStep3Data(phonePrefix: String, phoneNumber: String, whatsapp: String?, instagram: String?, twitter: String?)
}

final class SignUpViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var signUpTitleLabel: UILabel!
    @IBOutlet private weak var progressBarLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var signupContentsView: CustomView!
    @IBOutlet weak var stepsCollectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: SignUpViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeToNotifications()
        setupUI()
        fillUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

// MARK: - Private functions
private extension SignUpViewController {
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(fillWhereDoYouLivePersonalDetails), name: .SendWhereDoYouLiveToSignUp, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        configureCollectionView(stepsCollectionView)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        progressView.trackTintColor = .customBlack.withAlphaComponent(0.2)
        signupContentsView.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        updateCurrentProgressBarView()
    }
    
    func fillUI() {
        setLocalizables()
    }
    
    func setLocalizables() {
        signUpTitleLabel.text = .SignUp.Title()
    }
    
    func updateCurrenCollectionViewItem(direction: MoveDirection) {
        let indexPath = IndexPath(item: viewModel.currentStep.rawValue, section: 0)
        stepsCollectionView.scrollToItem(at: indexPath, at: direction == .back ? .left : .right, animated: true)
    }
    
    func updateCurrentProgressBarView() {
        let percentageInFloat = (1.0 / Float(self.viewModel.numberOfSteps)) * (Float(self.viewModel.currentStep.rawValue) + 1.0)
        progressView.setProgress(percentageInFloat, animated: true)
        UIView.transition(with: progressBarLabel, duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            self.progressBarLabel.text = self.viewModel.currentStepLabel.rawValue.localized
        })
    }
    
    @objc func fillWhereDoYouLivePersonalDetails(_ notification: NSNotification) {
        if let whereDoYouLive = notification.userInfo?["whereDoYouLive"] as? String {
            let indexPath = IndexPath(item: 0, section: 0)
            guard let personalDetailsCollectionViewCell = stepsCollectionView.cellForItem(at: indexPath) as? PersonalDetailsCollectionViewCell else { return }
            personalDetailsCollectionViewCell.fillWhereDoYouLive(whereDoYouLive: whereDoYouLive)
        }
    }
}

// MARK: - Functions
extension SignUpViewController {
    func fillWhereCanWeFindYouPersonalDetails(whereCanWeFindYouSearchResult: MKLocalSearchCompletion) {
        let indexPath = IndexPath(item: 0, section: 0)
        guard let personalDetailsCollectionViewCell = stepsCollectionView.cellForItem(at: indexPath) as? PersonalDetailsCollectionViewCell else { return }
        personalDetailsCollectionViewCell.fillWhereCanWeFindYou(searchResult: whereCanWeFindYouSearchResult)
    }
    
    func fillWhereCanWeFindYouPersonalDetails(addressString: String) {
        let indexPath = IndexPath(item: 0, section: 0)
        guard let personalDetailsCollectionViewCell = stepsCollectionView.cellForItem(at: indexPath) as? PersonalDetailsCollectionViewCell else { return }
        personalDetailsCollectionViewCell.fillWhereCanWeFindYou(addressString: addressString)
    }
    
    func fillPhonePrefixOfSocialMediaDetails(dialCode: String) {
        let indexPath = IndexPath(item: 2, section: 0)
        guard let socialMediaDetailsCollectionViewCell = stepsCollectionView.cellForItem(at: indexPath) as? SocialMediaDetailsCollectionViewCell else { return }
        socialMediaDetailsCollectionViewCell.fillPhonePrefix(dialCode: dialCode)
    }
    
    func stopLoadingGetStartedButton() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: 2, section: 0)
            guard let socialMediaDetailsCollectionViewCell = self.stepsCollectionView.cellForItem(at: indexPath) as? SocialMediaDetailsCollectionViewCell else { return }
            socialMediaDetailsCollectionViewCell.getStartedButton.hideLoading {
                socialMediaDetailsCollectionViewCell.updateUserInteraction()
            }
        }
    }
    
    func moveToPreviousStep() {
        switch viewModel.currentStep {
        case .personalDetails: return
        case .accountDetails:
            viewModel.currentStep = .personalDetails
            viewModel.currentStepLabel = .personalDetails
        case .socialMediaDetails:
            viewModel.currentStep = .accountDetails
            viewModel.currentStepLabel = .accountDetails
        }
        updateCurrenCollectionViewItem(direction: .back)
        updateCurrentProgressBarView()
    }
    
    func moveToNextStep() {
        switch viewModel.currentStep {
        case .personalDetails:
            viewModel.currentStep = .accountDetails
            viewModel.currentStepLabel = .accountDetails
        case .accountDetails:
            viewModel.currentStep = .socialMediaDetails
            viewModel.currentStepLabel = .socialMediaDetails
        case .socialMediaDetails:
            viewModel.didPressGetStartedButton {
                self.stopLoadingGetStartedButton()
            }
        }
        updateCurrenCollectionViewItem(direction: .next)
        updateCurrentProgressBarView()
    }
    
    func goToWhereDoYouLive(comesFrom: WhereDoYouLiveComesFrom) {
        viewModel.didPressGoToWhereDoYouLiveCountries(comesFrom: comesFrom)
    }
    
    func goToWhereCanWeFindYouAddress() {
        viewModel.didPressGoToWhereCanWeFindYou()
    }
    
    func goToTermsAndConditionsVC() {
        viewModel.didPressGoToTermsAndConditions()
    }
}
