//
//  MyPetViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum MyPetField {
    case name
    case type
    case breed
    case description
}

final class MyPetViewModel {
    // MARK: - Properties
    private let router: MyPetRouter
    let myPet: Pet?
    var numberOfTextFields = 2
    var editedTextFields = [CustomTextField]()
    var selectPhotoImageViews: [UIImageView] = []
    var selectedIndexImageView = 0
    var currentPetValues: [MyPetField: String] = [:]
    var newPetValues: [MyPetField: String] = [:]
    var imagesModified = false
    
    // MARK: - Init
    required init(router: MyPetRouter, myPet: Pet?) {
        self.router = router
        self.myPet = myPet
        if let myPet = myPet {
            self.currentPetValues[.name] = myPet.name
            self.currentPetValues[.type] = myPet.type.rawValue
            self.currentPetValues[.breed] = myPet.breed ?? ""
            self.currentPetValues[.description] = myPet.description ?? ""
            self.newPetValues = currentPetValues
        }
    }
}

// MARK: - Life cycle
extension MyPetViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension MyPetViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors { haveErrors = true }
        }
        return haveErrors
    }
    
    func getImagesFromImageViews() -> [UIImage?] {
        var images: [UIImage] = []
        selectPhotoImageViews.forEach { imageView in
            imageView.transform.rotated(by: .pi / 2)
            if let image = imageView.image, !image.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder")) {
                images.append(image)
            }
        }
        return images
    }
    
    func dismiss() {
        self.router.goBack()
    }
    
    func didPressSelectPhotoButton() {
        guard let selectPhotoImageView = selectPhotoImageViews[selectedIndexImageView].image else { return }
        self.router.goToSelectPhotoPopup(showRemoveOption: !selectPhotoImageView.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder")))
    }
    
    func didPressAnimalTypeButton() {
        self.router.goToAnimalTypes(comesFrom: .newPost)
    }
    
    func didPressRemoveMyPetDataButton(completion: @escaping (() -> Void)) {
        // TODO: - Call deleteMyPet API call
        completion()
        self.router.goBack()
    }
    
    func didPressSaveChangesButton(myPet: Pet?, completion: @escaping (() -> Void)) {
        if let myPet = myPet {
            /*self.postService.uploadPost(post: newPost, images: getImagesFromImageViews()) { result in
                switch result {
                case .success:
                    self.reloadPosts()
                    showSuccessPopup(title: .NewPostGeneric.PostPublished()) {
                        self.router.goBackToTabBar()
                    }
                    completion()
                case .error(let error):
                    showErrorPopup(title: error)
                    completion()
                }
            }*/
        } else {
            showErrorPopup(title: .ServiceErrors.Unexpected())
            completion()
        }
    }
}
