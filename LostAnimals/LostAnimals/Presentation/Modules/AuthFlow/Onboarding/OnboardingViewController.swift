//
//  OnboardingViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import UIKit

final class OnboardingViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var onboardingCollectionView: UICollectionView!
  @IBOutlet weak var onboardingImageView: UIImageView!
  @IBOutlet weak var previousOnboardingStepView: UIView!
  @IBOutlet weak var nextOnboardingStepImageView: UIImageView!
  
  // MARK: - Properties
  override var hideNavigationBar: Bool {
    return true
  }
  var viewModel: OnboardingViewModel!
  
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
    configureCollectionView(onboardingCollectionView)
  }
  
  private func updateCollectionViewItem(direction: MoveDirection) {
    let indexPath = IndexPath(item: viewModel.currentOnboardingStep.rawValue, section: 0)
    onboardingCollectionView.scrollToItem(at: indexPath, at: direction == .next ? .right : .left, animated: true)
  }
  
  private func updateOnboardingStepButtons() {
    previousOnboardingStepView.isHidden = viewModel.currentOnboardingStep == .share
    nextOnboardingStepImageView.image = viewModel.currentOnboardingStep == .contact ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "chevron.right.circle.fill")
  }
  
  private func updateOnboardingStepImage() {
    onboardingImageView.image = Constants.onboardingStepsInfo[viewModel.currentOnboardingStep.rawValue].image
  }
  
  private func moveToNextOnboardingStep() {
    switch viewModel.currentOnboardingStep {
    case .share:
      viewModel.currentOnboardingStep = .find
    case .find:
      viewModel.currentOnboardingStep = .contact
    case .contact:
      viewModel.didPressFinishOnboarding()
    }
    updateCollectionViewItem(direction: .next)
    updateOnboardingStepButtons()
    updateOnboardingStepImage()
  }
  
  private func moveToPreviousOnboardingStep() {
    switch viewModel.currentOnboardingStep {
    case .share: return
    case .find:
      viewModel.currentOnboardingStep = .share
    case .contact:
      viewModel.currentOnboardingStep = .find
    }
    updateCollectionViewItem(direction: .back)
    updateOnboardingStepButtons()
    updateOnboardingStepImage()
  }
  
  @IBAction func previousOnboardingStepButtonPressed(_ sender: UIButton) {
    moveToPreviousOnboardingStep()
  }
  
  @IBAction func nextOnboardingStepButtonPressed(_ sender: UIButton) {
    moveToNextOnboardingStep()
  }
}
