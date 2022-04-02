//
//  EditPostViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class EditPostViewModel {
    // MARK: - Properties
    private let router: EditPostRouter
    var numberOfTextFields = 0
    var editedTextFields = [CustomTextField]()
    var selectPhotoImageViews: [UIImageView] = []
    var selectedIndexImageView = 0
    var newPostLocation: Location? = nil
    let post: Post
    
    // MARK: - Init
    required init(router: EditPostRouter, post: Post) {
        self.router = router
        self.post = post
        switch post.postType {
        case .lost:
            numberOfTextFields = 4
        case .found:
            numberOfTextFields = 3
        case .adopt:
            numberOfTextFields = 2
        }
    }
}

// MARK: - Life cycle
extension EditPostViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension EditPostViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors { haveErrors = true }
        }
        return haveErrors
    }
    
    func didPressSelectPhotoButton() {
        guard let selectPhotoImageView = selectPhotoImageViews[selectedIndexImageView].image else { return }
        self.router.goToSelectPhotoPopup(showRemoveOption: !selectPhotoImageView.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder")))
    }
    
    func didPressAnimalTypeButton() {
        self.router.goToAnimalTypes(selectedAnimalType: post.animalType)
    }
    
    func didPressLocationButton() {
        self.router.goToWhereCanWeFindYou()
    }
    
    func didPressDeletePostButton() {
        showSuccessPopup(title: "The post has been removed sucessfully") {
            self.router.goBack2Times()
        }
    }
    
    func didPressSaveChangesButton() {
        showSuccessPopup(title: "The changes has been saved successfully") {
            self.router.goBack()
        }
    }
}
