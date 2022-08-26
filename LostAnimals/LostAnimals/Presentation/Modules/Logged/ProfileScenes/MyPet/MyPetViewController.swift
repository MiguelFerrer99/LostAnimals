//
//  MyPetViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol MyPetDelegate: AnyObject {
    func updateMyPet()
    func openNewPost(postToLoad: Post, imagesToLoad: [UIImage])
}

final class MyPetViewController: ViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var selectPhoto1ImageView: CustomImageView!
    @IBOutlet private weak var selectPhoto2ImageView: CustomImageView!
    @IBOutlet private weak var selectPhoto3ImageView: CustomImageView!
    @IBOutlet private weak var selectPhoto4ImageView: CustomImageView!
    @IBOutlet private weak var selectPhoto5ImageView: CustomImageView!
    @IBOutlet private weak var selectPhoto6ImageView: CustomImageView!
    @IBOutlet private weak var selectPhoto7ImageView: CustomImageView!
    @IBOutlet private weak var selectPhoto8ImageView: CustomImageView!
    @IBOutlet private weak var loadingIndicator1: UIActivityIndicatorView!
    @IBOutlet private weak var loadingIndicator2: UIActivityIndicatorView!
    @IBOutlet private weak var loadingIndicator3: UIActivityIndicatorView!
    @IBOutlet private weak var loadingIndicator4: UIActivityIndicatorView!
    @IBOutlet private weak var loadingIndicator5: UIActivityIndicatorView!
    @IBOutlet private weak var loadingIndicator6: UIActivityIndicatorView!
    @IBOutlet private weak var loadingIndicator7: UIActivityIndicatorView!
    @IBOutlet private weak var loadingIndicator8: UIActivityIndicatorView!
    @IBOutlet private weak var selectPhoto1Button: UIButton!
    @IBOutlet private weak var selectPhoto2Button: UIButton!
    @IBOutlet private weak var selectPhoto3Button: UIButton!
    @IBOutlet private weak var selectPhoto4Button: UIButton!
    @IBOutlet private weak var selectPhoto5Button: UIButton!
    @IBOutlet private weak var selectPhoto6Button: UIButton!
    @IBOutlet private weak var selectPhoto7Button: UIButton!
    @IBOutlet private weak var selectPhoto8Button: UIButton!
    @IBOutlet private weak var mustSelectOnePhotoLabel: UILabel!
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var haveYouLostYourPetButton: UIButton!
    @IBOutlet weak var descriptionCharactersCounterLabel: UILabel!
    @IBOutlet weak var animalNameTextfield: CustomTextField!
    @IBOutlet weak var animalTypeTextfield: CustomTextField!
    @IBOutlet weak var animalBreedTextfield: CustomTextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var removePetDataButton: CustomButton!
    @IBOutlet weak var saveChangesButton: CustomButton!
    
    // MARK: - Properties
    override var navBarTitle: String {
        return .Profile.MyPet()
    }
    override var hideBackButton: Bool {
        return true
    }
    override var navBarRightButtons: [UIBarButtonItem] {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(dismissVC))
        return [closeButton]
    }
    var viewModel: MyPetViewModel!
    let imagePickerController = UIImagePickerController()
    var delegate: MyPetDelegate?
    
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
extension MyPetViewController {
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
        animalTypeTextfield.textField.text = animalTypeName
        animalTypeTextfield.didFinishSelectContentFromOtherVC()
        viewModel.newPetValues[.type] = animalType.rawValue
    }
    
    func removePhoto() {
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

// MARK: - Private functions
private extension MyPetViewController {
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
        viewModel.selectPhotoButtons = [
            selectPhoto1Button,
            selectPhoto2Button,
            selectPhoto3Button,
            selectPhoto4Button,
            selectPhoto5Button,
            selectPhoto6Button,
            selectPhoto7Button,
            selectPhoto8Button
        ]
        if viewModel.myPet != nil { viewModel.selectPhotoButtons.forEach { $0.isEnabled = false } }
        viewModel.loadingIndicators = [
            loadingIndicator1,
            loadingIndicator2,
            loadingIndicator3,
            loadingIndicator4,
            loadingIndicator5,
            loadingIndicator6,
            loadingIndicator7,
            loadingIndicator8
        ]
        if let myPet = viewModel.myPet { fillUI(myPet) }
        configureTextfields()
        configureTextView()
        configureImagePickerController()
        setLocalizables()
    }
    
    func fillUI(_ myPet: Pet) {
        fillMyPetImages()
        haveYouLostYourPetButton.isHidden = false
        removePetDataButton.isHidden = false
        animalNameTextfield.textField.text = myPet.name
        switch myPet.type {
        case .dog:    animalTypeTextfield.textField.text = .Commons.AnimalTypeDog()
        case .cat:    animalTypeTextfield.textField.text = .Commons.AnimalTypeCat()
        case .bird:   animalTypeTextfield.textField.text = .Commons.AnimalTypeBird()
        case .rabbit: animalTypeTextfield.textField.text = .Commons.AnimalTypeRabbit()
        case .snake:  animalTypeTextfield.textField.text = .Commons.AnimalTypeSnake()
        case .turtle: animalTypeTextfield.textField.text = .Commons.AnimalTypeTurtle()
        case .other:  animalTypeTextfield.textField.text = .Commons.AnimalTypeOther()
        }
        if let breed = myPet.breed {
            animalBreedTextfield.textField.text = breed
        } else {
            animalBreedTextfield.textField.text = .Commons.NotSpecifiedFemale()
        }
        if let description = myPet.description {
            descriptionTextView.text = description
            descriptionCharactersCounterLabel.text = "\(description.count)/300"
        } else {
            descriptionTextView.text = .Commons.NotSpecifiedFemale()
        }
    }
    
    func fillMyPetImages() {
        viewModel.getImagesFromURLImages {
            for index in 0..<self.viewModel.postImages.count {
                DispatchQueue.main.async {
                    self.viewModel.photosSelected[index] = true
                    self.viewModel.selectPhotoButtons[index].isEnabled = true
                    self.viewModel.loadingIndicators[index].stopAnimating()
                    self.viewModel.selectPhotoImageViews[index].image = self.viewModel.postImages[index]
                    if index == self.viewModel.postImages.count - 1 {
                        self.viewModel.selectPhotoButtons.forEach { $0.isEnabled = true }
                        self.haveYouLostYourPetButton.isEnabled = true
                        self.haveYouLostYourPetButton.alpha = 1
                    }
                }
            }
        }
    }
    
    func setLocalizables() {
        mustSelectOnePhotoLabel.text = .NewPostGeneric.MustSelectPhoto()
        animalNameTextfield.placeholder = .Commons.AnimalName()
        animalTypeTextfield.placeholder = .Commons.Animal()
        animalBreedTextfield.placeholder = .Commons.AnimalBreed()
        descriptionTitleLabel.text = .Commons.AnimalDescription()
        haveYouLostYourPetButton.setTitle(.Commons.HaveYouLostYourPet(), for: .normal)
        removePetDataButton.setTitle(.Commons.RemovePetData(), for: .normal)
        saveChangesButton.setTitle(.Commons.SaveChanges(), for: .normal)
    }
    
    func updateUserInteraction() {
        tabBarController?.tabBar.isUserInteractionEnabled = saveChangesButton.isEnabled || removePetDataButton.isEnabled
        navigationController?.navigationBar.isUserInteractionEnabled = saveChangesButton.isEnabled || removePetDataButton.isEnabled
        animalNameTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled || removePetDataButton.isEnabled
        animalTypeTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled || removePetDataButton.isEnabled
        animalBreedTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled || removePetDataButton.isEnabled
        descriptionTextView.isUserInteractionEnabled = saveChangesButton.isEnabled || removePetDataButton.isEnabled
        haveYouLostYourPetButton.isUserInteractionEnabled = saveChangesButton.isEnabled || removePetDataButton.isEnabled
        viewModel.selectPhotoButtons.forEach { $0.isUserInteractionEnabled = saveChangesButton.isEnabled || removePetDataButton.isEnabled }
    }
    
    func buildMyPet() -> Pet? {
        guard let selectedAnimalTypeString = viewModel.newPetValues[.type],
              let selectedAnimalType = AnimalType(rawValue: selectedAnimalTypeString) else { return nil }
        let myPet = Pet(urlImage1: nil,
                        urlImage2: nil,
                        urlImage3: nil,
                        urlImage4: nil,
                        urlImage5: nil,
                        urlImage6: nil,
                        urlImage7: nil,
                        urlImage8: nil,
                        name: animalNameTextfield.value,
                        type: selectedAnimalType,
                        breed: animalBreedTextfield.value.isEmpty ? nil : animalBreedTextfield.value,
                        description: descriptionTextView.text.isEmpty ? nil: descriptionTextView.text)
        return myPet
    }
    
    @objc func dismissVC() {
        showConfirmationPopup(title: .NewPostGeneric.AreYouSureExit()) {
            self.viewModel.dismiss()
        }
    }
}

// MARK: - IBActions
private extension MyPetViewController {
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
    
    @IBAction func lostYourPetButtonPressed(_ sender: UIButton) {
        viewModel.didPressLostYourPetButton()
    }
    
    @IBAction func removePetDataButtonPressed(_ sender: CustomButton) {
        showConfirmationPopup(title: .Commons.AreYouSureRemovePetData()) {
            self.removePetDataButton.showLoading { self.updateUserInteraction() }
            self.viewModel.didPressRemoveMyPetDataButton {
                self.delegate?.updateMyPet()
                self.removePetDataButton.hideLoading { self.updateUserInteraction() }
                showSuccessPopup(title: .Commons.PetDataRemoved()) {
                    self.viewModel.dismiss()
                }
            } finishedKO: {
                self.removePetDataButton.hideLoading { self.updateUserInteraction() }
            }
        }
    }
    
    @IBAction func saveChangesButtonPressed(_ sender: CustomButton) {
        saveChangesButton.showLoading { self.updateUserInteraction() }
        viewModel.didPressSaveChangesButton(myPet: buildMyPet()) {
            self.delegate?.updateMyPet()
            self.saveChangesButton.hideLoading { self.updateUserInteraction() }
            showSuccessPopup(title: .Commons.ChangesSaved()) {
                self.viewModel.dismiss()
            }
        } finishedKO: {
            self.saveChangesButton.hideLoading { self.updateUserInteraction() }
        }
    }
}
