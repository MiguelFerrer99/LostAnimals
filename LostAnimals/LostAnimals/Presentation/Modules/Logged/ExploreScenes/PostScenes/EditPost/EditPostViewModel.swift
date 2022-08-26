//
//  EditPostViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 4/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum EditPostInfo {
    case animalType
    case animalName
    case animalBreed
    case lastTimeSeen
    case description
}

final class EditPostViewModel {
    // MARK: - Properties
    private let router: EditPostRouter
    var numberOfTextFields = 0
    var editedTextFields = [CustomTextField]()
    var selectPhotoImageViews: [UIImageView] = []
    var selectPhotoButtons: [UIButton] = []
    var selectedIndexImageView = 0
    var currentLocation: Location
    var newLocation: Location
    let post: Post
    let postImages: [UIImage]
    var currentEditPostInfo: [EditPostInfo: String] = [:]
    var newEditPostInfo: [EditPostInfo: String] = [:]
    var photosSelected = [Bool]()
    var imagesModified = false
    
    // MARK: - Services
    let userService = UserService()
    let postService = PostService()
    
    // MARK: - Init
    required init(router: EditPostRouter, post: Post, postImages: [UIImage]) {
        self.router = router
        self.post = post
        self.postImages = postImages
        self.currentLocation = post.location
        self.newLocation = post.location
        self.currentEditPostInfo[.animalType] = post.animalType.rawValue
        self.currentEditPostInfo[.animalName] = post.animalName ?? ""
        self.currentEditPostInfo[.animalBreed] = post.animalBreed
        self.currentEditPostInfo[.lastTimeSeen] = post.lastTimeSeen
        self.currentEditPostInfo[.description] = post.description
        self.newEditPostInfo = currentEditPostInfo
        switch post.postType {
        case .lost:  numberOfTextFields = 4
        case .found: numberOfTextFields = 3
        case .adopt: numberOfTextFields = 2
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
    
    func getModifiedPost() -> Post {
        var newPost = post
        newPost.animalName = (newEditPostInfo[.animalName] ?? "").isEmpty ? nil : newEditPostInfo[.animalName]
        newPost.animalType = AnimalType(rawValue: newEditPostInfo[.animalType] ?? "") ?? .other
        newPost.animalBreed = (newEditPostInfo[.animalBreed] ?? "").isEmpty ? nil : newEditPostInfo[.animalBreed]
        newPost.lastTimeSeen = newEditPostInfo[.lastTimeSeen] ?? Date().toString(withFormat: DateFormat.dayMonthYearHourOther)
        newPost.location = newLocation
        newPost.description = (newEditPostInfo[.description] ?? "").isEmpty ? nil : newEditPostInfo[.description]
        return newPost
    }
    
    func getModifiedImages() -> [UIImage] {
        var modifiedImages: [UIImage] = []
        for (index, imageView) in selectPhotoImageViews.enumerated() {
            if let image = imageView.image, photosSelected[index] {
                modifiedImages.append(image)
            }
        }
        return modifiedImages
    }
    
    func goBack() {
        showConfirmationPopup(title: .NewPostGeneric.AreYouSureExit()) {
            self.router.goBack()
        }
    }
    
    func didPressSelectPhotoButton() {
        self.router.goToSelectPhotoPopup(showRemoveOption: photosSelected[selectedIndexImageView])
    }
    
    func didPressAnimalTypeButton() {
        self.router.goToAnimalTypes(selectedAnimalType: post.animalType)
    }
    
    func didPressLocationButton() {
        self.router.goToWhereCanWeFindYou()
    }
    
    func didPressDeletePostButton(completion: @escaping (() -> Void)) {
        userService.deletePost(post: post) { result in
            switch result {
            case .success:
                NotificationCenter.default.post(name: .UpdateMyPosts, object: nil)
                NotificationCenter.default.post(name: .UpdateExplorePosts, object: nil)
                NotificationCenter.default.post(name: .UpdateSavedPosts, object: nil)
                completion()
                showSuccessPopup(title: .EditPost.PostDeleted()) {
                    self.router.goBack2Times()
                }
            case .error(let error):
                completion()
                showErrorPopup(title: error)
            }
        }
    }
    
    func didPressSaveChangesButton(completion: @escaping (() -> Void)) {
        let modifiedPost = self.getModifiedPost()
        let modifiedImages = self.getModifiedImages()
        self.postService.uploadPost(post: modifiedPost, images: modifiedImages) { uploadResult in
            switch uploadResult {
            case .success:
                NotificationCenter.default.post(name: .UpdateMyPosts, object: nil)
                NotificationCenter.default.post(name: .UpdateExplorePosts, object: nil)
                NotificationCenter.default.post(name: .UpdateSavedPosts, object: nil)
                completion()
                showSuccessPopup(title: .Commons.ChangesSaved()) {
                    self.router.goBack2Times()
                }
            case .error(let error):
                completion()
                showErrorPopup(title: error)
            }
        }
    }
}
