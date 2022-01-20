//
//  NewPostGenericViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class NewPostGenericViewController: ViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var postTypeLabel: UILabel!
  @IBOutlet weak var selectPhoto1ImageView: UIImageView!
  @IBOutlet weak var selectPhoto2ImageView: UIImageView!
  @IBOutlet weak var selectPhoto3ImageView: UIImageView!
  @IBOutlet weak var selectPhoto4ImageView: UIImageView!
  @IBOutlet weak var selectPhoto5ImageView: UIImageView!
  @IBOutlet weak var selectPhoto6ImageView: UIImageView!
  @IBOutlet weak var selectPhoto7ImageView: UIImageView!
  @IBOutlet weak var selectPhoto8ImageView: UIImageView!
  @IBOutlet weak var selectPhoto1Button: UIButton!
  @IBOutlet weak var selectPhoto2Button: UIButton!
  @IBOutlet weak var selectPhoto3Button: UIButton!
  @IBOutlet weak var selectPhoto4Button: UIButton!
  @IBOutlet weak var selectPhoto5Button: UIButton!
  @IBOutlet weak var selectPhoto6Button: UIButton!
  @IBOutlet weak var selectPhoto7Button: UIButton!
  @IBOutlet weak var selectPhoto8Button: UIButton!
  @IBOutlet weak var nameTextfield: CustomTextField!
  @IBOutlet weak var animalTextfield: CustomTextField!
  @IBOutlet weak var breedTextfield: CustomTextField!
  @IBOutlet weak var lastTimeSeenTextfield: CustomTextField!
  @IBOutlet weak var locationTextfield: CustomTextField!
  @IBOutlet weak var descriptionTextview: UITextView!
  @IBOutlet weak var publishPostButton: CustomButton!
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "New post"
  }
  var viewModel: NewPostGenericViewModel!
  let imagePickerController = UIImagePickerController()
  
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
    NotificationCenter.default.addObserver(self, selector: #selector(fillWhereCanWeFindYou), name: .SendWhereCanWeFindYouAddressToNewPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(fillAnimal), name: .SendAnimalToNewPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(removePhoto), name: .RemovePhotoFromSelectPhotoPopupFromNewPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(chooseFromLibrary), name: .ChooseFromLibraryFromSelectPhotoPopupFromNewPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(takeAPhoto), name: .TakeAPhotoFromSelectPhotoPopupFromNewPost, object: nil)
  }
  
  private func unsubscribeToNotifications() {
    NotificationCenter.default.removeObserver(self)
  }
  
  private func setupUI() {
    viewModel.selectPhotoImageViews = [selectPhoto1ImageView, selectPhoto2ImageView, selectPhoto3ImageView, selectPhoto4ImageView,
                                       selectPhoto5ImageView, selectPhoto6ImageView, selectPhoto7ImageView, selectPhoto8ImageView]
    configureTextfields()
    configureImagePickerController()
    fillUI()
  }
  
  private func fillUI() {
    switch viewModel.postType {
    case .lost:
      postTypeLabel.text = "Lost animal"
    case .found:
      postTypeLabel.text = "Found animal"
      nameTextfield.isHidden = true
    case .adopt:
      postTypeLabel.text = "To adopt animal"
      lastTimeSeenTextfield.isHidden = true
      locationTextfield.isHidden = true
    }
  }
  
  @objc private func removePhoto(_ notification: NSNotification) {
    viewModel.selectPhotoImageViews[viewModel.selectedIndexImageView].image = UIImage(named: "SelectPhotoPlaceholder")
    checkAllContentsAreOk()
  }
  
  @objc private func chooseFromLibrary(_ notification: NSNotification) {
    self.imagePickerController.sourceType = .photoLibrary
    self.present(viewController: imagePickerController, completion: nil)
  }
  
  @objc private func takeAPhoto(_ notification: NSNotification) {
    self.imagePickerController.sourceType = .camera
    self.present(viewController: imagePickerController, completion: nil)
  }
  
  private func updateUserInteraction() {
    navigationController?.navigationBar.isUserInteractionEnabled = publishPostButton.isEnabled
    navigationController?.interactivePopGestureRecognizer?.isEnabled = publishPostButton.isEnabled
    nameTextfield.isUserInteractionEnabled = publishPostButton.isEnabled
    animalTextfield.isUserInteractionEnabled = publishPostButton.isEnabled
    breedTextfield.isUserInteractionEnabled = publishPostButton.isEnabled
    lastTimeSeenTextfield.isUserInteractionEnabled = publishPostButton.isEnabled
    locationTextfield.isUserInteractionEnabled = publishPostButton.isEnabled
    descriptionTextview.isUserInteractionEnabled = publishPostButton.isEnabled
    selectPhoto1Button.isUserInteractionEnabled = publishPostButton.isEnabled
    selectPhoto2Button.isUserInteractionEnabled = publishPostButton.isEnabled
    selectPhoto3Button.isUserInteractionEnabled = publishPostButton.isEnabled
    selectPhoto4Button.isUserInteractionEnabled = publishPostButton.isEnabled
    selectPhoto5Button.isUserInteractionEnabled = publishPostButton.isEnabled
    selectPhoto6Button.isUserInteractionEnabled = publishPostButton.isEnabled
    selectPhoto7Button.isUserInteractionEnabled = publishPostButton.isEnabled
    selectPhoto8Button.isUserInteractionEnabled = publishPostButton.isEnabled
  }
  
  // MARK: - IBAction
  @IBAction func selectPhoto1ButtonPressed(_ sender: UIButton) {
    viewModel.selectedIndexImageView = 0
    viewModel.didPressSelectPhotoButton()
  }
  
  @IBAction func selectPhoto2ButtonPressed(_ sender: UIButton) {
    viewModel.selectedIndexImageView = 1
    viewModel.didPressSelectPhotoButton()
  }
  
  @IBAction func selectPhoto3ButtonPressed(_ sender: UIButton) {
    viewModel.selectedIndexImageView = 2
    viewModel.didPressSelectPhotoButton()
  }
  
  @IBAction func selectPhoto4ButtonPressed(_ sender: UIButton) {
    viewModel.selectedIndexImageView = 3
    viewModel.didPressSelectPhotoButton()
  }
  
  @IBAction func selectPhoto5ButtonPressed(_ sender: UIButton) {
    viewModel.selectedIndexImageView = 4
    viewModel.didPressSelectPhotoButton()
  }
  
  @IBAction func selectPhoto6ButtonPressed(_ sender: UIButton) {
    viewModel.selectedIndexImageView = 5
    viewModel.didPressSelectPhotoButton()
  }
  
  @IBAction func selectPhoto7ButtonPressed(_ sender: UIButton) {
    viewModel.selectedIndexImageView = 6
    viewModel.didPressSelectPhotoButton()
  }
  
  @IBAction func selectPhoto8ButtonPressed(_ sender: UIButton) {
    viewModel.selectedIndexImageView = 7
    viewModel.didPressSelectPhotoButton()
  }
  
  @IBAction func publishPostButtonPressed(_ sender: CustomButton) {
    publishPostButton.showLoading()
    updateUserInteraction()
    viewModel.didPressPublishPostButton()
  }
}
