//
//  SignUpViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class SignUpViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var progressBarLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var signupContentsView: CustomView!
  @IBOutlet weak var stepsCollectionView: UICollectionView!
  
  // MARK: - Properties
  var viewModel: SignUpViewModel!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupBindings()
    viewModel.viewReady()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewModel.viewDidAppear()
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
  }
  
  private func setupUI() {
    configureCollectionView(stepsCollectionView)
    progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
    progressView.trackTintColor = .customBlack.withAlphaComponent(0.2)
    signupContentsView.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    updateCurrentProgressBarView()
  }
  
  private func updateCurrenCollectionViewItem(direction: SignUpMoveDirection) {
    let indexPath = IndexPath(item: viewModel.currentStep.rawValue, section: 0)
    stepsCollectionView.scrollToItem(at: indexPath, at: direction == .back ? .left : .right, animated: true)
  }
  
  private func updateCurrentProgressBarView() {
    let percentageInFloat = (1.0 / Float(self.viewModel.numberOfSteps)) * (Float(self.viewModel.currentStep.rawValue) + 1.0)
    progressView.setProgress(percentageInFloat, animated: true)
    UIView.transition(with: progressBarLabel, duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in
      guard let self = self else { return }
      self.progressBarLabel.text = self.viewModel.currentStepLabel.rawValue
    })
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
      // TODO: Go to Onboarding/Explore
      return
    }
    updateCurrenCollectionViewItem(direction: .next)
    updateCurrentProgressBarView()
  }
  
  func goToWhereDoYouLive() {
    viewModel.didPressGoToWhereDoYouLiveCountries()
  }
  
  func goToWhereCanWeFindYouAddress() {
    viewModel.didPressGoToWhereCanWeFindYou()
  }
}
