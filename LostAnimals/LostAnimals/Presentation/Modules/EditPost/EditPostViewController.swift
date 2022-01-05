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
  @IBOutlet weak var nameTextfield: CustomTextField!
  @IBOutlet weak var animalTextfield: CustomTextField!
  @IBOutlet weak var breedTextfield: CustomTextField!
  @IBOutlet weak var lastTimeSeenTextfield: CustomTextField!
  @IBOutlet weak var locationTextfield: CustomTextField!
  @IBOutlet weak var descriptionTextview: UITextView!
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
      selectPhotoImageView.element.image = postImage != nil ? postImage : UIImage(named: "SelectImagePlaceholder")
    }
    nameTextfield.textField.text = viewModel.post.animal.name
    animalTextfield.textField.text = viewModel.post.animal.type.rawValue
    breedTextfield.textField.text = viewModel.post.animal.breed
    lastTimeSeenTextfield.textField.text = viewModel.post.lastTimeSeen.toString(withFormat: DateFormat.dayMonthYearOther)
    locationTextfield.textField.text = viewModel.post.address
  }
  
  // MARK: - IBAction
  @IBAction func selectPhoto1ButtonPressed(_ sender: UIButton) {
    // TODO: Open SelectPhotoPopup
  }
  
  @IBAction func selectPhoto2ButtonPressed(_ sender: UIButton) {
    // TODO: Open SelectPhotoPopup
  }
  
  @IBAction func selectPhoto3ButtonPressed(_ sender: UIButton) {
    // TODO: Open SelectPhotoPopup
  }
  
  @IBAction func selectPhoto4ButtonPressed(_ sender: UIButton) {
    // TODO: Open SelectPhotoPopup
  }
  
  @IBAction func selectPhoto5ButtonPressed(_ sender: UIButton) {
    // TODO: Open SelectPhotoPopup
  }
  
  @IBAction func selectPhoto6ButtonPressed(_ sender: UIButton) {
    // TODO: Open SelectPhotoPopup
  }
  
  @IBAction func selectPhoto7ButtonPressed(_ sender: UIButton) {
    // TODO: Open SelectPhotoPopup
  }
  
  @IBAction func selectPhoto8ButtonPressed(_ sender: UIButton) {
    // TODO: Open SelectPhotoPopup
  }
  
  @IBAction func deletePostButtonPressed(_ sender: CustomButton) {
    viewModel.didPressDeletePostButton()
  }
  
  @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
    viewModel.didPressSaveChangesButton()
  }
}
