//
//  EditPostViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditPostViewController: ViewController {
  
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
  @IBOutlet weak var deletePostButton: CustomButton!
  @IBOutlet weak var saveChangesButton: CustomButton!
  
  // MARK: - Properties
  override var navBarTitle: String {
    return "Edit post"
  }
  var viewModel: EditPostViewModel!
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
    NotificationCenter.default.addObserver(self, selector: #selector(fillWhereCanWeFindYou), name: .SendWhereCanWeFindYouAddressToEditPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(fillAnimal), name: .SendAnimalToEditPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(removePhoto), name: .RemovePhotoFromSelectPhotoPopupFromEditPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(chooseFromLibrary), name: .ChooseFromLibraryFromSelectPhotoPopupFromEditPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(takeAPhoto), name: .TakeAPhotoFromSelectPhotoPopupFromEditPost, object: nil)
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
    switch viewModel.post.postType {
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
    
    viewModel.selectPhotoImageViews.enumerated().forEach { selectPhotoImageView in
      if selectPhotoImageView.offset <= viewModel.post.animal.images.count - 1 {
        let postImage = viewModel.post.animal.images[selectPhotoImageView.offset]
        selectPhotoImageView.element.image = postImage
      } else {
        selectPhotoImageView.element.image = UIImage(named: "SelectPhotoPlaceholder")
      }
    }
    
    nameTextfield.textField.text = viewModel.post.animal.name
    animalTextfield.textField.text = viewModel.post.animal.type.rawValue
    breedTextfield.textField.text = viewModel.post.animal.breed == nil ? "Not specified" : viewModel.post.animal.breed
    descriptionTextview.text = viewModel.post.description == nil ? "Without description" : viewModel.post.description
    
    if let lastTimeSeen = viewModel.post.lastTimeSeen {
      lastTimeSeenTextfield.textField.text = lastTimeSeen.toString(withFormat: DateFormat.dayMonthYearOther)
    }
    
    if let location = viewModel.post.location {
      locationTextfield.textField.text = location.address
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
    navigationController?.navigationBar.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    navigationController?.interactivePopGestureRecognizer?.isEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    nameTextfield.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    animalTextfield.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    breedTextfield.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    lastTimeSeenTextfield.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    locationTextfield.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    descriptionTextview.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    selectPhoto1Button.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    selectPhoto2Button.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    selectPhoto3Button.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    selectPhoto4Button.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    selectPhoto5Button.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    selectPhoto6Button.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    selectPhoto7Button.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
    selectPhoto8Button.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
  }
  
  // MARK: - IBActions
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
  
  @IBAction func deletePostButtonPressed(_ sender: CustomButton) {
    deletePostButton.showLoading()
    updateUserInteraction()
    viewModel.didPressDeletePostButton()
  }
  
  @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
    saveChangesButton.showLoading()
    updateUserInteraction()
    viewModel.didPressSaveChangesButton()
  }
}
