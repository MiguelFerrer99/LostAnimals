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
    
    func setupUI() {
        viewModel.selectPhotoImageViews = [selectPhoto1ImageView, selectPhoto2ImageView, selectPhoto3ImageView, selectPhoto4ImageView,
                                           selectPhoto5ImageView, selectPhoto6ImageView, selectPhoto7ImageView, selectPhoto8ImageView]
        configureTextfields()
        configureImagePickerController()
        fillUI()
    }
    
    func fillUI() {
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
            if selectPhotoImageView.offset <= viewModel.post.images.count - 1 {
                let postImage = viewModel.post.images[selectPhotoImageView.offset]
                selectPhotoImageView.element.image = postImage
            } else {
                selectPhotoImageView.element.image = UIImage(named: "SelectPhotoPlaceholder")
            }
        }
        
        nameTextfield.textField.text = viewModel.post.animalName
        animalTextfield.textField.text = viewModel.post.animalType.rawValue
        breedTextfield.textField.text = viewModel.post.animalBreed
        descriptionTextview.text = viewModel.post.description
        lastTimeSeenTextfield.textField.text = viewModel.post.lastTimeSeen
        locationTextfield.textField.text = viewModel.post.location.address
    }
}

// MARK: - Functions
extension EditPostViewController {
    func fillAnimal(animalType: AnimalType) {
        animalTextfield.textField.text = animalType.rawValue
        animalTextfield.didFinishSelectContentFromOtherVC()
    }
    
    func removePhoto() {
        viewModel.selectPhotoImageViews[viewModel.selectedIndexImageView].image = UIImage(named: "SelectPhotoPlaceholder")
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
        deletePostButton.showLoading {
            self.updateUserInteraction()
        }
        viewModel.didPressDeletePostButton()
    }

    @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
        saveChangesButton.showLoading {
            self.updateUserInteraction()
        }
        viewModel.didPressSaveChangesButton()
    }

}
