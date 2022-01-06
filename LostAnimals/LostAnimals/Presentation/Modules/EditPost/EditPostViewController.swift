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
  var descriptionPlaceholderModeEnabled = true
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(fillWhereCanWeFindYou), name: .SendWhereCanWeFindYouAddressToEditPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(fillAnimal), name: .SendAnimalToEditPost, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(removePhoto), name: .RemovePhotoFromSelectPhotoPopup, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(chooseFromLibrary), name: .ChooseFromLibraryFromSelectPhotoPopup, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(takeAPhoto), name: .TakeAPhotoFromSelectPhotoPopup, object: nil)
    
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
    viewModel.selectPhotoImageViews = [selectPhoto1ImageView, selectPhoto2ImageView, selectPhoto3ImageView, selectPhoto4ImageView,
                                       selectPhoto5ImageView, selectPhoto6ImageView, selectPhoto7ImageView, selectPhoto8ImageView]
    configureTextfields()
    fillUI()
  }
  
  private func fillUI() {
    switch viewModel.post.postType {
    case .lost: postTypeLabel.text = "Lost animal"
    case .found: postTypeLabel.text = "Found animal"
    case .adopt: postTypeLabel.text = "To adopt animal"
    }
    viewModel.selectPhotoImageViews.enumerated().forEach { selectPhotoImageView in
      let postImage = viewModel.post.postImages[selectPhotoImageView.offset]
      selectPhotoImageView.element.image = postImage != nil ? postImage : UIImage(named: "SelectPhotoPlaceholder")
    }
    nameTextfield.textField.text = viewModel.post.animal.name
    animalTextfield.textField.text = viewModel.post.animal.type.rawValue
    breedTextfield.textField.text = viewModel.post.animal.breed
    lastTimeSeenTextfield.textField.text = viewModel.post.lastTimeSeen.toString(withFormat: DateFormat.dayMonthYearOther)
    locationTextfield.textField.text = viewModel.post.address
    descriptionTextview.text = viewModel.post.description
  }
  
  @objc private func removePhoto(_ notification: NSNotification) {
    if let indexImageView = notification.userInfo?["indexImageView"] as? Int {
      viewModel.selectPhotoImageViews[indexImageView].image = UIImage(named: "SelectPhotoPlaceholder")
    }
  }
  
  @objc private func chooseFromLibrary(_ notification: NSNotification) {
    if let indexImageView = notification.userInfo?["indexImageView"] as? Int {
      print(indexImageView)
      // TODO: Go to chooseFromLibraryVC
    }
  }
  
  @objc private func takeAPhoto(_ notification: NSNotification) {
    if let indexImageView = notification.userInfo?["indexImageView"] as? Int {
      print(indexImageView)
      // TODO: Go to takeAPhotoVC
    }
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
  
  // MARK: - IBAction
  @IBAction func selectPhoto1ButtonPressed(_ sender: UIButton) {
    viewModel.didPressSelectPhotoButton(indexImageView: 0)
  }
  
  @IBAction func selectPhoto2ButtonPressed(_ sender: UIButton) {
    viewModel.didPressSelectPhotoButton(indexImageView: 1)
  }
  
  @IBAction func selectPhoto3ButtonPressed(_ sender: UIButton) {
    viewModel.didPressSelectPhotoButton(indexImageView: 2)
  }
  
  @IBAction func selectPhoto4ButtonPressed(_ sender: UIButton) {
    viewModel.didPressSelectPhotoButton(indexImageView: 3)
  }
  
  @IBAction func selectPhoto5ButtonPressed(_ sender: UIButton) {
    viewModel.didPressSelectPhotoButton(indexImageView: 4)
  }
  
  @IBAction func selectPhoto6ButtonPressed(_ sender: UIButton) {
    viewModel.didPressSelectPhotoButton(indexImageView: 5)
  }
  
  @IBAction func selectPhoto7ButtonPressed(_ sender: UIButton) {
    viewModel.didPressSelectPhotoButton(indexImageView: 6)
  }
  
  @IBAction func selectPhoto8ButtonPressed(_ sender: UIButton) {
    viewModel.didPressSelectPhotoButton(indexImageView: 7)
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
