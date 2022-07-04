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
    @IBOutlet private weak var lostYourPetBottomView: UIView!
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
        viewModel.selectPhotoImageViews = [selectPhoto1ImageView, selectPhoto2ImageView, selectPhoto3ImageView, selectPhoto4ImageView,
                                           selectPhoto5ImageView, selectPhoto6ImageView, selectPhoto7ImageView, selectPhoto8ImageView]
        if let myPet = viewModel.myPet { fillUI(myPet) }
        configureTextfields()
        configureTextView()
        configureImagePickerController()
        setLocalizables()
    }
    
    func fillUI(_ myPet: Pet) {
        fillMyPetImages()
        haveYouLostYourPetButton.isHidden = false
        lostYourPetBottomView.isHidden = false
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
        } else {
            descriptionTextView.text = .Commons.NotSpecifiedFemale()
        }
    }
    
    func fillMyPetImages() {
        viewModel.getImagesFromURLImages {
            for index in 0..<self.viewModel.postImages.count {
                DispatchQueue.main.async {
                    self.viewModel.selectPhotoImageViews[index].image = self.viewModel.postImages[index]
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
        navigationController?.navigationBar.isUserInteractionEnabled = saveChangesButton.isEnabled
        animalNameTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        animalTypeTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        animalBreedTextfield.isUserInteractionEnabled = saveChangesButton.isEnabled
        descriptionTextView.isUserInteractionEnabled = saveChangesButton.isEnabled
        selectPhoto1Button.isUserInteractionEnabled = saveChangesButton.isEnabled
        selectPhoto2Button.isUserInteractionEnabled = saveChangesButton.isEnabled
        selectPhoto3Button.isUserInteractionEnabled = saveChangesButton.isEnabled
        selectPhoto4Button.isUserInteractionEnabled = saveChangesButton.isEnabled
        selectPhoto5Button.isUserInteractionEnabled = saveChangesButton.isEnabled
        selectPhoto6Button.isUserInteractionEnabled = saveChangesButton.isEnabled
        selectPhoto7Button.isUserInteractionEnabled = saveChangesButton.isEnabled
        selectPhoto8Button.isUserInteractionEnabled = saveChangesButton.isEnabled
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
