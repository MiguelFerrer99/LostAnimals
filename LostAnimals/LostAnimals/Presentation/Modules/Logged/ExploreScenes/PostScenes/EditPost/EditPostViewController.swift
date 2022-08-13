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
    @IBOutlet private weak var postTypeLabel: UILabel!
    @IBOutlet private weak var selectPhoto1ImageView: UIImageView!
    @IBOutlet private weak var selectPhoto2ImageView: UIImageView!
    @IBOutlet private weak var selectPhoto3ImageView: UIImageView!
    @IBOutlet private weak var selectPhoto4ImageView: UIImageView!
    @IBOutlet private weak var selectPhoto5ImageView: UIImageView!
    @IBOutlet private weak var selectPhoto6ImageView: UIImageView!
    @IBOutlet private weak var selectPhoto7ImageView: UIImageView!
    @IBOutlet private weak var selectPhoto8ImageView: UIImageView!
    @IBOutlet private weak var selectPhoto1Button: UIButton!
    @IBOutlet private weak var selectPhoto2Button: UIButton!
    @IBOutlet private weak var selectPhoto3Button: UIButton!
    @IBOutlet private weak var selectPhoto4Button: UIButton!
    @IBOutlet private weak var selectPhoto5Button: UIButton!
    @IBOutlet private weak var selectPhoto6Button: UIButton!
    @IBOutlet private weak var selectPhoto7Button: UIButton!
    @IBOutlet private weak var selectPhoto8Button: UIButton!
    @IBOutlet private weak var deletePostButton: CustomButton!
    @IBOutlet private weak var descriptionOptionalLabel: UILabel!
    @IBOutlet private weak var mustSelectPhotoLabel: UILabel!
    @IBOutlet weak var nameTextfield: CustomTextField!
    @IBOutlet weak var animalTextfield: CustomTextField!
    @IBOutlet weak var breedTextfield: CustomTextField!
    @IBOutlet weak var lastTimeSeenTextfield: CustomTextField!
    @IBOutlet weak var locationTextfield: CustomTextField!
    @IBOutlet weak var descriptionTextview: UITextView!
    @IBOutlet weak var descriptionCharactersCounterLabel: UILabel!
    @IBOutlet weak var saveChangesButton: CustomButton!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return .EditPost.Title()
    }
    override var navBarLeftButtons: [UIBarButtonItem] {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        return [backButton]
    }
    var viewModel: EditPostViewModel!
    let imagePickerController = UIImagePickerController()
    
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
}

// MARK: - Private functions
private extension EditPostViewController {
    func updateUserInteraction() {
        navigationController?.navigationBar.isUserInteractionEnabled = deletePostButton.isEnabled || saveChangesButton.isEnabled
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
    
    func setupUI() {
        viewModel.selectPhotoImageViews = [
            selectPhoto1ImageView,
            selectPhoto2ImageView,
            selectPhoto3ImageView,
            selectPhoto4ImageView,
            selectPhoto5ImageView,
            selectPhoto6ImageView,
            selectPhoto7ImageView,
            selectPhoto8ImageView
        ]
        for _ in 0..<8 { viewModel.photosSelected.append(false) }
        configureTextView()
        configureImagePickerController()
        fillUI()
        configureTextfields()
        setLocalizables()
    }
    
    func fillUI() {
        switch viewModel.post.postType {
        case .lost:
            postTypeLabel.text = .Post.LostPostTypeTitle()
        case .found:
            postTypeLabel.text = .Post.FoundPostTypeTitle()
            nameTextfield.isHidden = true
        case .adopt:
            postTypeLabel.text = .Post.ToAdoptPostTypeTitle()
            lastTimeSeenTextfield.isHidden = true
            locationTextfield.isHidden = true
        }
        
        for index in 0..<viewModel.postImages.count {
            viewModel.selectPhotoImageViews[index].image = viewModel.postImages[index]
            viewModel.photosSelected[index] = !viewModel.postImages[index].isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder"))
        }
        
        nameTextfield.textField.text = viewModel.post.animalName
        animalTextfield.textField.text = viewModel.post.animalType.rawValue
        breedTextfield.textField.text = viewModel.post.animalBreed
        descriptionTextview.text = viewModel.post.description
        descriptionCharactersCounterLabel.text = "\(descriptionTextview.text.count)/300"
        lastTimeSeenTextfield.textField.text = viewModel.post.lastTimeSeen
        locationTextfield.textField.text = viewModel.currentLocation.address
    }
    
    func setLocalizables() {
        nameTextfield.placeholder = .Commons.AnimalName()
        animalTextfield.placeholder = .Commons.Animal()
        breedTextfield.placeholder = .Commons.AnimalBreed()
        lastTimeSeenTextfield.placeholder = .Commons.AnimalLastTimeSeen()
        locationTextfield.placeholder = .Commons.AnimalLocation()
        descriptionOptionalLabel.text = .Commons.AnimalDescription()
        mustSelectPhotoLabel.text = .NewPostGeneric.MustSelectPhoto()
        deletePostButton.setTitle(.EditPost.DeletePost(), for: .normal)
        saveChangesButton.setTitle(.Commons.SaveChanges(), for: .normal)
    }
    
    @objc func goBack() {
        viewModel.goBack()
    }
}

// MARK: - Functions
extension EditPostViewController {
    func fillAnimal(animalType: AnimalType) {
        var animalTypeName: String = .Commons.AnimalTypeOther()
        switch animalType {
        case .dog:    animalTypeName = .Commons.AnimalTypeDog()
        case .bird:   animalTypeName = .Commons.AnimalTypeBird()
        case .cat:    animalTypeName = .Commons.AnimalTypeCat()
        case .turtle: animalTypeName = .Commons.AnimalTypeTurtle()
        case .snake:  animalTypeName = .Commons.AnimalTypeSnake()
        case .rabbit: animalTypeName = .Commons.AnimalTypeRabbit()
        case .other:  animalTypeName = .Commons.AnimalTypeOther()
        }
        viewModel.newEditPostInfo[.animalType] = animalTypeName
        animalTextfield.textField.text = animalTypeName
        animalTextfield.didFinishSelectContentFromOtherVC()
    }
    
    func removePhoto() {
        viewModel.imagesModified = true
        viewModel.selectPhotoImageViews[viewModel.selectedIndexImageView].image = UIImage(named: "SelectPhotoPlaceholder")
        viewModel.photosSelected[viewModel.selectedIndexImageView] = false
        checkAllContentsAreOk()
    }
    
    func choosePhoto() {
        self.imagePickerController.sourceType = .photoLibrary
        self.present(viewController: imagePickerController, completion: nil)
    }
    
    func takePhoto() {
        self.imagePickerController.sourceType = .camera
        self.present(viewController: imagePickerController, completion: nil)
    }
}

// MARK: - IBActions
private extension EditPostViewController {
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
        showConfirmationPopup(title: .Commons.AreYouSureDeletePost()) {
            self.deletePostButton.showLoading { self.updateUserInteraction() }
            self.viewModel.didPressDeletePostButton {
                self.deletePostButton.hideLoading { self.updateUserInteraction() }
            }
        }
    }

    @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
        saveChangesButton.showLoading { self.updateUserInteraction() }
        viewModel.didPressSaveChangesButton() {
            self.saveChangesButton.hideLoading { self.updateUserInteraction() }
        }
    }
}
