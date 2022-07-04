//
//  NewPostGenericViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum PostType: String {
    case lost = "Lost"
    case found = "Found"
    case adopt = "Adopt"
    
    func toDTO() -> String {
        self.rawValue.lowercased()
    }
}

final class NewPostGenericViewModel {
    // MARK: - Properties
    private let router: NewPostGenericRouter
    var numberOfTextFields = 0
    var editedTextFields = [CustomTextField]()
    let postType: PostType
    let postToLoad: Post?
    var selectPhotoImageViews: [UIImageView] = []
    var selectedIndexImageView = 0
    var newPostLocation = Location(address: .Commons.NotSpecifiedFemale(), coordinates: nil)
    var selectedAnimalType: AnimalType? = nil
    
    // MARK: - Services
    let postService = PostService()
    
    // MARK: - Init
    required init(router: NewPostGenericRouter, postType: PostType, postToLoad: Post? = nil) {
        self.router = router
        self.postType = postType
        self.postToLoad = postToLoad
        switch postType {
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
extension NewPostGenericViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension NewPostGenericViewModel {
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
    
    func reloadPosts() {
        NotificationCenter.default.post(name: .UpdateExplorePosts, object: nil)
        NotificationCenter.default.post(name: .UpdateMyPosts, object: nil)
    }
    
    func goBack() {
        showConfirmationPopup(title: .NewPostGeneric.AreYouSureExit()) {
            self.router.goBack()
        }
    }
    
    func didPressSelectPhotoButton() {
        guard let selectPhotoImageView = selectPhotoImageViews[selectedIndexImageView].image else { return }
        self.router.goToSelectPhotoPopup(showRemoveOption: !selectPhotoImageView.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder")))
    }
    
    func didPressAnimalTypeButton() {
        self.router.goToAnimalTypes(comesFrom: .newPost)
    }
    
    func didPressLocationButton() {
        self.router.goToWhereCanWeFindYou()
    }
    
    func didPressPublishPostButton(newPost: Post?, completion: @escaping (() -> Void)) {
        if let newPost = newPost {
            self.postService.uploadPost(post: newPost, images: getImagesFromImageViews()) { result in
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
            }
        } else {
            showErrorPopup(title: .ServiceErrors.Unexpected())
            completion()
        }
    }
}
