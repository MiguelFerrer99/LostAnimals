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
    @IBOutlet private weak var descriptionTextview: UITextView!
    @IBOutlet weak var nameTextfield: CustomTextField!
    @IBOutlet weak var animalTextfield: CustomTextField!
    @IBOutlet weak var breedTextfield: CustomTextField!
    @IBOutlet weak var lastTimeSeenTextfield: CustomTextField!
    @IBOutlet weak var locationTextfield: CustomTextField!
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
        
        setupUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

// MARK: - Functions
extension NewPostGenericViewController {
    func fillAnimal(animalType: AnimalType) {
        animalTextfield.textField.text = animalType.rawValue
        animalTextfield.didFinishSelectContentFromOtherVC()
        viewModel.selectedAnimalType = animalType
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

// MARK: - Private functions
private extension NewPostGenericViewController {
    func setupUI() {
        viewModel.selectPhotoImageViews = [selectPhoto1ImageView, selectPhoto2ImageView, selectPhoto3ImageView, selectPhoto4ImageView,
                                           selectPhoto5ImageView, selectPhoto6ImageView, selectPhoto7ImageView, selectPhoto8ImageView]
        configureTextfields()
        configureImagePickerController()
        fillUI()
    }
    
    func fillUI() {
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
    
    func updateUserInteraction() {
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
    
    func buildNewPost() -> Post? {
        guard let selectedAnimalType = viewModel.selectedAnimalType,
              let animalNameText = nameTextfield.textField.text,
              let animalBreedText = breedTextfield.textField.text,
              let lastTimeSeenText = lastTimeSeenTextfield.textField.text,
              let me = User.shared
        else { return nil }
                
        let newPost = Post(id: UUID().uuidString,
                           postType: viewModel.postType,
                           animalName: animalNameText.isEmpty ? "Not specified" : animalNameText,
                           animalType: selectedAnimalType,
                           animalBreed: animalBreedText,
                           urlImage1: nil,
                           urlImage2: nil,
                           urlImage3: nil,
                           urlImage4: nil,
                           urlImage5: nil,
                           urlImage6: nil,
                           urlImage7: nil,
                           urlImage8: nil,
                           lastTimeSeen: lastTimeSeenText,
                           location: viewModel.newPostLocation,
                           description: descriptionTextview.text,
                           userID: me.id,
                           createdAt: Date.today)
        
        return newPost
    }
}

// MARK: - IBActions
private extension NewPostGenericViewController {
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
        publishPostButton.showLoading {
            self.updateUserInteraction()
        }
        viewModel.didPressPublishPostButton(newPost: buildNewPost()) {
            self.publishPostButton.hideLoading {
                self.updateUserInteraction()
            }
        }
    }
}
