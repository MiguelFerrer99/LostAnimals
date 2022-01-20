//
//  ContactWithPopupViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit
import MessageUI

final class ContactWithPopupViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var contactWithPopupView: CustomView!
  @IBOutlet weak var mailView: CustomView!
  @IBOutlet weak var phoneView: CustomView!
  @IBOutlet weak var whatsappView: CustomView!
  @IBOutlet weak var instagramView: CustomView!
  @IBOutlet weak var twitterView: CustomView!
  
  // MARK: - Properties
  var viewModel: ContactWithPopupViewModel!
  let mailController = MFMailComposeViewController()
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    UIView.animate(withDuration: 0.25) {
      self.backgroundView.alpha = 0.6
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    UIView.animate(withDuration: 0.25) {
      self.backgroundView.alpha = 0
    }
  }
  
  // MARK: - Functions  
  private func setupUI() {
    contactWithPopupView.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    instagramView.isHidden = viewModel.authorSocialMedias.instagram == nil
    twitterView.isHidden = viewModel.authorSocialMedias.twitter == nil
    configureMailController(mailController: mailController)
  }
  
  // MARK: - IBActions
  @IBAction func backgroundButtonPressed(_ sender: UIButton) {
    viewModel.dismissButtonPressed()
  }
  
  @IBAction func mailViewButtonPressed(_ sender: UIButton) {
    sendEmail(email: viewModel.authorSocialMedias.email)
  }
  
  @IBAction func phoneViewButtonPressed(_ sender: UIButton) {
    viewModel.didPressPhoneButton()
  }
  
  @IBAction func whatsappViewButtonPressed(_ sender: UIButton) {
    viewModel.didPressWhatsappButton()
  }
  
  @IBAction func instagramViewButtonPressed(_ sender: UIButton) {
    viewModel.didPressInstagramButton()
  }
  
  @IBAction func twitterButtonPressed(_ sender: UIButton) {
    viewModel.didPressTwitterButton()
  }
}
